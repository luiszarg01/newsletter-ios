//
//  Singleton.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-28.
//

import Foundation

struct Singleton {
    static var shared = Singleton()
    
    var posts:[PostPersistModel] = []
    
    func clear() {
        Singleton.shared.posts = []
    }
    
}
