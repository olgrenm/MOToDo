//
//  ItemsView.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI

struct ItemsView: View {
    enum FilterType {
        case none, dated, someday, asap
    }
    
    let filter: FilterType
    
    @Environment(\.managedObjectContext) private var viewContext

    
    @State private var addViewShown = false
    let viewModel = ListViewModel()
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Item.isComplete, order: .forward),
            SortDescriptor(\Item.name, order: .forward)
        ],
        animation: .default)
        private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredItems) { item in
                    NavigationLink {
                        AddItemView(itemId: item.objectID)
                    } label: {
                        ItemView(item: item)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(
                        for: indexSet,
                           section: items,
                           viewContext: viewContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddItemView()
            }
            .navigationTitle(title)
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everything"
        case .dated:
            return "Dated items"
        case .someday:
            return "Someday"
        case .asap:
            return "ASAP"
        }
    }
    
    var filteredItems: [Item] {
        switch filter {
        case .none:
            return items.filter { $0.isComplete || !$0.isComplete }
        case .dated:
            return items.filter { $0.category == "dated" }
        case .someday:
            return items.filter { $0.category == "someday" }
        case .asap:
            return items.filter { $0.category == "asap"}
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(filter: .none)
    }
}
