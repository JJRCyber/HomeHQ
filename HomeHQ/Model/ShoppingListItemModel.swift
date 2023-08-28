//
//  ShoppingListItemModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 28/8/2023.
//

import Foundation

class ShoppingListItem: ObservableObject, Identifiable {
    let id: String
    let name: String
    @Published var quantity: Int
    @Published var completed: Bool
    
    init(id: String = UUID().uuidString, name: String, quantity: Int = 1, completed: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
    }
    
    func toggleCompleted() {
        self.completed.toggle()
    }
    
    func updateQuantity(newQuantity: Int) {
        self.quantity = newQuantity
    }
}
