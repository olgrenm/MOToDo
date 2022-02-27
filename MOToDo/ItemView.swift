//
//  ItemView.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            Text(item.isComplete ? Image(systemName: "checkmark.square") : Image(systemName: "square"))
                .font(.title)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title)
                Text(item.desc)
                if item.category == "dated" {
                    Text("Due: \(item.dateDue.formatted(date: .numeric, time: .omitted))")
                }
            }
            Spacer()
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: getItem())
    }
    
    static func getItem() -> Item {
        let item = Item(context: PersistenceManager(inMemory: true).persistentContainer.viewContext)
        item.name = "Test"
        item.desc = "fake desc"
        item.isComplete = false
        item.dateDue = Date()
        item.category = "dated"
        return item
    }
}
