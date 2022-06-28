//
//  PostsViewModel.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import Foundation

final class PostsViewModel {
    
    var posts:[PostModel] = []
    
    var filteredPosts:[PostModel] = [] {
        
        didSet {
            onPostsChanged?()
        }
        
    }
    var selectedPost:PostModel!
    var comments:[PostComment] = []
    var author:UserModel!
    var onPostsChanged: ( () -> Void )?
    var postsCoreDataAdapter = PostsCoreDataAdapter()
    
    func getPosts(onResponse: @escaping (() -> Void)) {

        self.postsCoreDataAdapter.getPostsFromCore()
        let posts = postsCoreDataAdapter.getPosts()
        
        if !posts.isEmpty {
            self.posts = posts
            self.filteredPosts = posts
        } else {
            getPostsFromAPI()
        }

    }
    
    func getPostsFromAPI() {
        
        HTTPClient.request(endpoint: "posts", onSuccess: { [weak self] (response:[PostModel]) in
            guard let self = self else { return }
            
            let cachedPosts = self.postsCoreDataAdapter.getPosts()
            
            for post in response {
                
                if Singleton.shared.posts.contains(where: { $0.id == post.id! }) { continue }
                self.postsCoreDataAdapter.createPost(model: post)
            }
            
            self.postsCoreDataAdapter.getPostsFromCore()
            self.posts = self.postsCoreDataAdapter.getPosts()
            self.filteredPosts = self.posts
            
        })

    }
    
    func getComments( onComplete: @escaping (() -> Void) ) {
        
        guard let id = selectedPost.id else { return }
        
        HTTPClient.request(endpoint: "posts/\(id)/comments", onSuccess: { [weak self] (response:[PostComment]) in
            guard let self = self else { return }
            self.comments = response
            onComplete()
        })
    }
    
    func getAuthor( onComplete: @escaping (() -> Void) ) {
        
        guard let id = selectedPost.userID else { return }
        
        HTTPClient.request(endpoint: "users/\(id)", onSuccess: { [weak self] (response:UserModel) in
            guard let self = self else { return }

            self.author = response
            onComplete()
        })
    }
    
    func setFavorite(onComplete: @escaping ((_ newFavorite:PostModel) -> Void)) {
        
        postsCoreDataAdapter.setFavorite(post: selectedPost)
        posts = postsCoreDataAdapter.getPosts()
        filteredPosts = posts
        selectedPost.favorite = !selectedPost.favorite
        onComplete(selectedPost)
        
    }
    
    func filterByFavorites() {
        
        filteredPosts = posts.filter { $0.favorite }
    }
    
    func removeAll() {
        
//        le.t noFavorites = posts.filter { !$0.favorite }
        let noFavoritesCore = Singleton.shared.posts.filter { !$0.favorite }
        
        //remove from core data
        noFavoritesCore.forEach { self.postsCoreDataAdapter.deletePost(model: $0) }
        
        //remove local
        posts = postsCoreDataAdapter.getPosts()
        filteredPosts = posts

    }
    
    func removePost(post:PostModel) {

        guard let post = (Singleton.shared.posts.first { $0.id == post.id! }) else { return }
        postsCoreDataAdapter.deletePost(model: post)
        
        posts = postsCoreDataAdapter.getPosts()
        filteredPosts = posts
        
    }
    
    
}
