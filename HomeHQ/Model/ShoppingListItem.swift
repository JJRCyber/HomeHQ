//
//  ShoppingListItemModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 28/8/2023.
//

import Foundation


// Model for item on shopping list
struct ShoppingListItem: Identifiable {
    let id: String
    let name: String
    let quantity: Int
    let completed: Bool
    
    
    // Custom init to allow creation and modification of ShoppingListItem
    // ShoppingListItem is immutable so all modifications are done by returning
    // a new object
    init(id: String = UUID().uuidString, name: String, quantity: Int = 1, completed: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
    }
    
    // Toggles completed on an object by returning a new object
    func toggleCompleted() -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: quantity, completed: !completed)
    }
    
    // Updates quantity on an object by returning a new object
    func updateQuantity(newQuantity: Int) -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: newQuantity, completed: completed)
    }
}
