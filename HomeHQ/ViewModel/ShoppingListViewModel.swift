//
//  RemindersViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

struct ShoppingListItem: Identifiable {
    let id: String
    let name: String
    let quantity: Int
    var completed: Bool = false
    
    init(id: String = UUID().uuidString, name: String, quantity: Int = 1, completed: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
    }
    
    func updateCompletion() -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: 3, completed: !completed)
    }
}

// View model for reminders view
class ShoppingListViewModel: ObservableObject {
    
    @Published var newItemName: String = ""
    
    @Published var shoppingList:[ShoppingListItem] = [
        ShoppingListItem(name: "Test", quantity: 5),
        ShoppingListItem(name: "Test2", quantity: 3)
    ]
    
    func deleteItem(at offsets: IndexSet) {
            shoppingList.remove(atOffsets: offsets)
        }
    
    func updateItemCompletion(item: ShoppingListItem) {
        if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
            shoppingList[index] = item.updateCompletion()
        }
    }
    
    func addItem() {
        let item = ShoppingListItem(name: newItemName)
        shoppingList.insert(item, at: 0)
        newItemName = ""
    }
}
