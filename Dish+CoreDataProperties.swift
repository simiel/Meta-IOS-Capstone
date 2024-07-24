//
//  Dish+CoreDataProperties.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 24/07/2024.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: String?
    @NSManaged public var image: String?
    @NSManaged public var category: String?

}

extension Dish : Identifiable {

}
