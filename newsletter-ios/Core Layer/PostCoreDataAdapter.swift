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
    
    func getPosts() -> [PostModel] {
        
        let request: NSFetchRequest<PostPersistModel> = PostPersistModel.fetchRequest()

        do {
           posts = try context.fetch(request)
        } catch {
            print("Error loading the data \(error)")
        }

        posts = posts.sorted(by: {$0.favorite && !$1.favorite})
        let result = posts.map { $0.toPostModel }

        return result
    }
    
    func savePost(model:PostModel) {
        
        let newPost = PostPersistModel(context: context)
        newPost.id = Int16(model.id!)
        newPost.userId = Int16(model.id!)
        newPost.title = model.title!
        newPost.body = model.body!
        newPost.favorite = model.favorite
        
        //persist new data
        savePostsContext()
    }
    
    func savePostsContext(){
        
        do {
            try context.save()
        } catch {
           print("Error saving context \(error)")
        }

    }
    
    func deletePost(model:PostModel){
        
        let post = PostPersistModel(context: context)
        post.id = Int16(model.id!)
        post.userId = Int16(model.id!)
        post.title = model.title!
        post.body = model.body!
        post.favorite = model.favorite
        
        context.delete(post)
        savePostsContext()
    }
    
}
