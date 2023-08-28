//
//  RemindersViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

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
        item.toggleCompleted()
    }
    
    func updateItemQuantity(item: ShoppingListItem, newQuantity: Int) {
        if newQuantity > 0 && newQuantity < 100 {
            item.updateQuantity(newQuantity: newQuantity)
        }
    }

    func addItem() {
        let item = ShoppingListItem(name: newItemName)
        shoppingList.insert(item, at: 0)
        newItemName = ""
    }
}