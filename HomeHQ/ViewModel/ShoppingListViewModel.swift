//
//  RemindersViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for reminders view
@MainActor
class ShoppingListViewModel: ObservableObject {
    
    @Published var home: HomeProfile? = nil
    
    // Bound to text field to add new item
    @Published var newItemName: String = ""
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    func loadCurrentHome() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        guard let homeId = user.homeId else { return }
        self.home = try await HomeManager.shared.getHome(homeId: homeId)
    }
    
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
//    func addItem() {
//        if isValidEntry() {
//            let item = ShoppingListItem(name: newItemName)
//            shoppingList.insert(item, at: 0)
//            newItemName = ""
//        }
//    }
    
    func addItem() {
        if isValidEntry() {
            guard let home else { return }
            let item = ShoppingListItem(name: newItemName)
            Task {
                try await HomeManager.shared.addShoppingListItem(homeId: home.homeId, shopppingListItem: item)
            }

            newItemName = ""
        }
    }
}
