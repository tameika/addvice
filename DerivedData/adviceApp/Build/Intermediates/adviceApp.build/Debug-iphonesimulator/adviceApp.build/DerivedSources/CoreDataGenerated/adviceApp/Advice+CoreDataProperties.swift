//
//  Advice+CoreDataProperties.swift
//  
//
<<<<<<< HEAD
//  Created by Tameika Lawrence on 2/13/17.
=======
//  Created by Tameika Lawrence on 2/11/17.
>>>>>>> 7ce786103cce040ca31c776e6ad13140c446a391
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
