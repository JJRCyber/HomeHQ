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
    
    // Bound to text field to add new item
    @Published var newItemName: String = ""
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    // Loads shopping list from Firestore
    func loadShoppingList() async {
        loadingState = .loading
        do {
            self.shoppingList = try await dataStore.homeManager.getShoppingList()
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
    }
    
    
    // Deletes item from array at specified offset
    // Performs instant view update then syncs with Firestore
    func deleteItem(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(atOffsets: offsets)
        Task {
            do {
                try await dataStore.homeManager.removeShoppingListItem(shoppingListItemId: shoppingListItemId)
                await loadShoppingList()
            } catch {
                // Displays alert popup if this fails
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Deletes item at specified index
    // Overloaded above function
    func deleteItem(at index: Int) {
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(at: index)
        Task {
            do {
                try await dataStore.homeManager.removeShoppingListItem(shoppingListItemId: shoppingListItemId)
                await loadShoppingList()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Finds the item in the array and calls the model function to update completion
    func updateItemCompletion(item: ShoppingListItem) {
        if let index = shoppingList.firstIndex(where: {$0.id == item.id}) {
            shoppingList[index] = item.toggleCompleted()
            // Deletes the item from array after 5 seconds if completion hasn't been undone
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if let currentIndex = self.shoppingList.firstIndex(where: {$0.id == item.id}) {
                    if self.shoppingList[currentIndex].completed {
                        self.deleteItem(at: currentIndex)
                    }
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
    
    // Adds an item to the Firestore shoppingList and refreshes the view
    func addItem() {
        if isValidEntry() {
            let item = ShoppingListItem(name: newItemName)
            Task {
                do {
                    try await dataStore.homeManager.addShoppingListItem(shopppingListItem: item)
                    await loadShoppingList()
                    newItemName = ""
                } catch {
                    showError = true
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
