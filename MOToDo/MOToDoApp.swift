//
//  MOToDoApp.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI

@main
struct MOToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
        }
    }
}
