//
//  PostPersistModel+CoreDataProperties.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//
//

import Foundation
import CoreData


extension PostPersistModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostPersistModel> {
        return NSFetchRequest<PostPersistModel>(entityName: "PostPersistModel")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userId: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var favorite: Bool

}

extension PostPersistModel : Identifiable {

    var toPostModel:PostModel {
        return PostModel(model: self)
    }
    
    
}
