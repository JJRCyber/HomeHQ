//
//  ShoppingListItemModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 28/8/2023.
//

import Foundation


// Model for item on shopping list
struct ShoppingListItem: Identifiable, Codable {
    let id: String
    let name: String
    let quantity: Int
    let completed: Bool
    let dateCreated: Date
    
    
    // Custom init to allow creation and modification of ShoppingListItem
    // ShoppingListItem is immutable so all modifications are done by returning
    // a new object
    init(id: String = UUID().uuidString, name: String, quantity: Int = 1, completed: Bool = false, dateCreated: Date = Date()) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
        self.dateCreated = dateCreated
    }
    
    // Custom coding keys for conversion to snake case for Firestore
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case quantity = "quantity"
        case completed = "completed"
        case dateCreated = "date_created"
    }
    
    // Init from Firestore document to ShoppingListItem
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.completed = try container.decode(Bool.self, forKey: .completed)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }
    
    // Encode from ShoppingListItem to Firestore document
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.quantity, forKey: .quantity)
        try container.encode(self.completed, forKey: .completed)
        try container.encode(self.dateCreated, forKey: .dateCreated)
    }
    
    // Toggles completed on an object by returning a new object
    func toggleCompleted() -> ShoppingListItem {
        return ShoppingListItem(id: id, name: name, quantity: quantity, completed: !completed)
    }
    
    // Updates quantity on an object by returning a new object
    func updateQuantity(newQuantity: Int) -> ShoppingListItem {
        let shoppingListItem = ShoppingListItem(id: id, name: name, quantity: newQuantity, completed: completed)
        Task {
            // Updates item quantity in Firestore
            try await HomeManager.shared.updateShoppingListItem(shoppingListItem: shoppingListItem)
        }
        return shoppingListItem
        
    }
}
