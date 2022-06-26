//
//  NewsLetterModel.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import Foundation


// MARK: - PostModel
struct PostModel: Codable {
    var userID, id: Int?
    var title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID
        case id, title, body
    }
}

// MARK: - PostComment
struct PostComment: Codable {
    var postID, id: Int?
    var name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID
        case id, name, email, body
    }
}
