//
//  PersistenceManager.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import Foundation
import CoreData

struct PersistenceManager {
    static let shared = PersistenceManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Stash")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
    
    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for itemNumber in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.name = "Item \(itemNumber)"
            newItem.desc = "test desc"
            newItem.isComplete = false
            newItem.dateDue = Date()
            newItem.category = "someday"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    } ()
}
