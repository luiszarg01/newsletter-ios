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
    var favorite:Bool = false

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
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

// MARK: - UserModel
struct UserModel: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?

    var formattedUsername: String {
        
        guard let username = username else { return "" }
        return "@\(username)"

    }
    
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}
