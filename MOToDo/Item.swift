//
//  Item.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @objc var dayDue: String {
        return dateDue.formatted(.dateTime.month(.wide).day().year())
    }
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var name: String
    @NSManaged public var desc: String
    @NSManaged public var isComplete: Bool
    @NSManaged public var dateDue: Date
    @NSManaged public var category: String
}

extension Item: Identifiable {}
