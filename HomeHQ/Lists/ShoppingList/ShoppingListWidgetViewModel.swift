//
//  ShoppingListWidgetViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 6/9/2023.
//

import Foundation

@MainActor
class ShoppingListWidgetViewModel: BaseViewModel, LoadData {
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    // Loads shopping list from Firestore
    func loadData() async {
        loadingState = .loading
        do {
            self.shoppingList = try await dataStore.homeManager.getShoppingList()
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
    }
    
    // Private function that is called when item is marked as completed
    // Widget view does not allow direct way to delete items
    private func deleteItem(at index: Int) {
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(at: index)
        Task {
            do {
                try await dataStore.homeManager.removeShoppingListItem(shoppingListItemId: shoppingListItemId)
                await loadData()
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
                if self.shoppingList[index].completed {
                    self.deleteItem(at: index)
                }
            }
        }
    }
    
}
