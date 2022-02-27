//
//  AddItemViewModel.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import Foundation
import CoreData

struct AddItemViewModel {
    func fetchItem(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> Item? {
        guard let item = context.object(with: objectId) as? Item else {
            return nil
        }
        
        return item
    }
    
    func saveItem(
        itemId: NSManagedObjectID?,
        with itemValues: ItemValues,
        in context: NSManagedObjectContext
    ) {
        let item: Item
        if let objectId = itemId,
           let fetchedItem = fetchItem(for: objectId, context: context) {
            item = fetchedItem
        } else {
            item = Item(context: context)
        }
        
        item.name = itemValues.name
        item.desc = itemValues.desc
        item.isComplete = itemValues.isComplete
        item.dateDue = itemValues.dateDue
        item.category = itemValues.category
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
