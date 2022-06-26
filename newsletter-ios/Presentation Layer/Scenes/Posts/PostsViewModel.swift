//
//  PostsViewModel.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import Foundation

final class PostsViewModel {
    
    var posts:[PostModel] = [] {
        
        didSet {
            onPostsChanged?()
        }
        
    }
    var selectedPost:PostModel!
    var comments:[PostComment] = []
    var author:UserModel!
    var onPostsChanged: ( () -> Void )?
    
    func getPosts(onResponse: @escaping (() -> Void)) {
        HTTPClient.request(endpoint: "posts", onSuccess: { [weak self] (response:[PostModel]) in
            guard let self = self else { return }
            self.posts = response
            self.onPostsChanged?()
            onResponse()
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
        selectedPost.favorite = !selectedPost.favorite
        onComplete(selectedPost)
        
    }
    
    
}
