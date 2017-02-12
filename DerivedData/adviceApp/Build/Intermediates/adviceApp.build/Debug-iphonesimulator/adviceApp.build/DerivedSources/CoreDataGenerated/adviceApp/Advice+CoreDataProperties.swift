//
//  Advice+CoreDataProperties.swift
//  
//
//  Created by Tameika Lawrence on 2/11/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Advice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Advice> {
        return NSFetchRequest<Advice>(entityName: "Advice");
    }

    @NSManaged public var content: String?
    @NSManaged public var isFavorited: Bool

}
