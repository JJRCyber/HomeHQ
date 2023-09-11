//
//  TabBarViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for Tab + Top bar view
@MainActor
final class TabBarViewModel: BaseViewModel {
    
    @Published var homeName = "Home 1"
    @Published var user: UserProfile?
    @Published var selectedTab: Int = 0
    
    override init() {
        super.init()
        loadingState = .loading
        Task {
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async {
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            if let homeId = self.user?.homeId {
                UserDefaults.standard.set(homeId, forKey: "homeId")
            }
            loadingState = .loaded
        } catch {
            showError = true
            errorMessage = error.localizedDescription
            loadingState = .error
        }
    }
}
