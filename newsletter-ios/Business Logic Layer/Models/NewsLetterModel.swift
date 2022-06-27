//
//  NewsLetterModel.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import Foundation
import UIKit


// MARK: - PostModel
struct PostModel: Codable, Equatable {
    var userID, id: Int?
    var title, body: String?
    
    //extra
    var favorite:Bool = false
    var image:UIImage?
    
    init(model:PostPersistModel) {
        self.userID = Int(model.id)
        self.id = Int(model.id)
        self.title = model.title
        self.body = model.body
        self.favorite = model.favorite
        self.image = UIImage(named: "resource\(Int.random(in: 1...10))")
    }
    

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
