//
//  ListViewModel.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI
import CoreData

struct ListViewModel {
    func deleteItem(
        for indexSet: IndexSet,
        section: FetchedResults<Item>,
        viewContext: NSManagedObjectContext
    ) {
        indexSet.map{ section[$0]}.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
