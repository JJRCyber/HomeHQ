//
//  ShoppingListItemModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 28/8/2023.
//

import Foundation

struct ShoppingListItem: Identifiable {
    let id: String
    let name: String
    let quantity: Int
    let completed: Bool
    
    init(id: String = UUID().uuidString, name: String, quantity: Int = 1, completed: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
    }
    
    func toggleCompleted() -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: quantity, completed: !completed)
    }
    
    func updateQuantity(newQuantity: Int) -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: newQuantity, completed: completed)
    }
}
