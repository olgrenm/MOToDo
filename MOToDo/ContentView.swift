//
//  ContentView.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ItemsView(filter: .asap)
                .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                .tabItem {
                    Label("ASAP", systemImage: "paperplane")
                }
            ItemsView(filter: .none)
                .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                .tabItem {
                    Label("All", systemImage: "tray.2")
                }
            ItemsView(filter: .dated)
                .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                .tabItem {
                    Label("Dated", systemImage: "calendar")
                }
            ItemsView(filter: .someday)
                .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                .tabItem {
                    Label("Someday", systemImage: "questionmark.diamond")
                }
        }
    }
}
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
