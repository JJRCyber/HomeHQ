//
//  RemindersViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for reminders view
class ShoppingListViewModel: ObservableObject {
    
    // Bound to text field to add new item
    @Published var newItemName: String = ""
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = [
        ShoppingListItem(name: "Test", quantity: 5),
        ShoppingListItem(name: "Test2", quantity: 3),
        ShoppingListItem(name: "Test", quantity: 5),
        ShoppingListItem(name: "Test2", quantity: 3),
        ShoppingListItem(name: "Test2", quantity: 3),
        ShoppingListItem(name: "Test", quantity: 5)
    ]
    
    // Deletes item from array at specified index
    func deleteItem(at offsets: IndexSet) {
            shoppingList.remove(atOffsets: offsets)
        }
    
    // Finds the item in the array and calls the model function to update completion
    func updateItemCompletion(item: ShoppingListItem) {
        if let index = shoppingList.firstIndex(where: {$0.id == item.id}) {
            shoppingList[index] = item.toggleCompleted()
        }
    }
    
    // Returns whether textfield is valid (has at least 1 character)
    func isValidEntry() -> Bool {
        return newItemName.count > 0
    }
    
    // Update the item quantity if more than 0 or less than 100
    func updateItemQuantity(item: ShoppingListItem, newQuantity: Int) {
        if newQuantity > 0 && newQuantity < 100 {
            if let index = shoppingList.firstIndex(where: {$0.id == item.id}) {
                shoppingList[index] = item.updateQuantity(newQuantity: newQuantity)
            }
        }
    }

    // Adds item to shoppingList if input is valid 
    func addItem() {
        if isValidEntry() {
            let item = ShoppingListItem(name: newItemName)
            shoppingList.insert(item, at: 0)
            newItemName = ""
        }
    }
}
