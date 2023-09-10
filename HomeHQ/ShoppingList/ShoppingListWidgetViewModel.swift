//
//  ShoppingListWidgetViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 6/9/2023.
//

import Foundation

@MainActor
class ShoppingListWidgetViewModel: BaseViewModel {
    
    @Published var loadingState: LoadingState = .idle
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    func loadShoppingList() async throws {
        loadingState = .loading
        guard let homeId = try await dataStore.userManager.getCurrentUser().homeId else { return }
//        self.homeId = homeId
        self.shoppingList = try await dataStore.homeManager.getShoppingList(homeId: homeId)
        loadingState = .loaded
    }
    
    func deleteItem(at index: Int) {
        guard let homeId else { return }
        let shoppingListItemId = shoppingList[index].id
        shoppingList.remove(at: index)
        Task {
            try await dataStore.homeManager.removeShoppingListItem(homeId: homeId, shoppingListItemId: shoppingListItemId)
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
    
}
