//
//  ShoppingListWidgetViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 6/9/2023.
//

import Foundation

@MainActor
class ShoppingListWidgetViewModel: BaseViewModel {
    
    @Published var home: HomeProfile? = nil
    
    // Array of ShoppingListItem
    @Published var shoppingList:[ShoppingListItem] = []
    
    func loadShoppingList() async throws {
        guard let homeId = try await dataStore.userManager.getCurrentUser().homeId else { return }
        self.shoppingList = try await dataStore.homeManager.getShoppingList(homeId: homeId)
    }
    
    // Finds the item in the array and calls the model function to update completion
    func updateItemCompletion(item: ShoppingListItem) {
        if let index = shoppingList.firstIndex(where: {$0.id == item.id}) {
            shoppingList[index] = item.toggleCompleted()
        }
    }
    
}
