//
//  AddItemView.swift
//  MOToDo
//
//  Created by Michael Olgren on 2/27/22.
//

import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var name = ""
    @State private var nameError = false
    @State private var desc = ""
    @State private var isComplete = false
    @State private var dateDue = Date()
    @State private var catagory = "asap"
    @State private var categories = ["asap", "dated", "someday"]
    
    var itemId: NSManagedObjectID?
    let viewModel = AddItemViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            TextField("Name", text: $name, prompt: Text("Name"))
                                .disableAutocorrection(true)
                                .font(.title)
                            if nameError {
                                Text("Name is required")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack {
                            Text("Description")
                                .font(.caption)
                            TextEditor(text: $desc)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .border(.secondary)
                            Picker("Category", selection: $catagory) {
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                }
                            } .pickerStyle(SegmentedPickerStyle())
                            Toggle("Completed?", isOn: $isComplete)
                        }
                    }
                    if catagory == "dated" {
                        Section {
                            DatePicker("Due Date", selection: $dateDue, in: Date.now..., displayedComponents: .date)
                        }
                    }
                } // end form
                Button {
                    if name.isEmpty {
                        nameError = name.isEmpty
                    } else {
                        let values = ItemValues(
                            name: name,
                            desc: desc,
                            isComplete: isComplete,
                            dateDue: dateDue,
                            category: catagory)
                        
                        viewModel.saveItem(
                            itemId: itemId,
                            with: values,
                            in: viewContext)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 300)
                }  // end button
                .tint(Color(.blue))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .controlSize(.large)
            } // end VStack
            .navigationTitle("\(itemId == nil ? "Add Item" : "Edit Item")")
            Spacer()
        } // end NavView
        .onAppear {
            guard
                let objectId = itemId,
                let item = viewModel.fetchItem(for: objectId, context: viewContext)
            else {
                return
            }
            
            name = item.name
            desc = item.desc
            isComplete = item.isComplete
            dateDue = item.dateDue
            catagory = item.category
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
