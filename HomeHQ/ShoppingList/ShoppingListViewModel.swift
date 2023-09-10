//
//  RemindersViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for reminders view
@MainActor
class ShoppingListViewModel: BaseViewModel {
    
    @Published var loadingState: LoadingState = .idle
    
    @Published var home: HomeProfile? = nil
    
    // Bound to text field to add new item
    @Published var newItemName: String = ""
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    func loadHome() async throws {
        loadingState = .loading
        let user = try await dataStore.userManager.getCurrentUser()
        if let homeId = user.homeId {
            self.home = try await dataStore.homeManager.getHome(homeId: homeId)
            try await loadShoppingList()
            loadingState = .loaded
        }
    }
    
    func loadShoppingList() async throws {
        let user = try await dataStore.userManager.getCurrentUser()
        if let homeId = user.homeId {
            self.shoppingList = try await HomeManager.shared.getShoppingList(homeId: homeId)
        }
    }
    
    
    // Deletes item from array at specified index
    func deleteItem(at offsets: IndexSet) {
        guard let home else { return }
        guard let index = offsets.first else { return }
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(atOffsets: offsets)
        Task {
            try await dataStore.homeManager.removeShoppingListItem(homeId: home.homeId, shoppingListItemId: shoppingListItemId)
            try await loadShoppingList()
        }
        }
    
    func deleteItem(at index: Int) {
        guard let home else { return }
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(at: index)
        Task {
            try await dataStore.homeManager.removeShoppingListItem(homeId: home.homeId, shoppingListItemId: shoppingListItemId)
            try await loadShoppingList()
        }
        }
    
    // Finds the item in the array and calls the model function to update completion
    func updateItemCompletion(item: ShoppingListItem) {
        if let index = shoppingList.firstIndex(where: {$0.id == item.id}) {
            shoppingList[index] = item.toggleCompleted()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if self.shoppingList[index].completed {
                    self.deleteItem(at: index)
                }
            }
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
                try await loadShoppingList()
            }
            newItemName = ""

        }
    }
}
