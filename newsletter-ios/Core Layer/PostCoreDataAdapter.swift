//
//  PostCoreDataAdapter.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import Foundation
import CoreData
import UIKit

class PostsCoreDataAdapter {
    
    var posts:[PostPersistModel] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPostsFromCore() {
        let request: NSFetchRequest<PostPersistModel> = PostPersistModel.fetchRequest()

        do {
            let result = try context.fetch(request)
            Singleton.shared.posts = result
        } catch {
            print("Error loading the data \(error)")
        }
    }
    
    func getPosts() -> [PostModel] {
        
        let temp = Singleton.shared.posts.sorted(by: {$0.favorite && !$1.favorite})
        let result = temp.map { $0.toPostModel }

        return result
    }
    
    func createPost(model:PostModel) {
        
        let newPost = PostPersistModel(context: context)
        newPost.id = Int16(model.id!)
        newPost.userId = Int16(model.id!)
        newPost.title = model.title!
        newPost.body = model.body!
        newPost.favorite = model.favorite
        
        //persist new data
        savePostsContext()
    }
    
    func setFavorite(post:PostModel) {
        guard let idx = (Singleton.shared.posts.firstIndex { $0.id == post.id! }) else { return }
        Singleton.shared.posts[idx].favorite = !Singleton.shared.posts[idx].favorite
        savePostsContext()
    }
    
    func savePostsContext(){
        
        do {
            try context.save()
        } catch {
           print("Error saving context \(error)")
        }
        
        getPostsFromCore()

    }
    
    func deletePost(model:PostPersistModel){
        
        context.delete(model)
        print("deleted")
        savePostsContext()
        
    }
    
}

