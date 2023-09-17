//
//  TabBarViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for Tab + Top bar view
@MainActor
final class TabBarViewModel: BaseViewModel, LoadData, UpdateValues {
    
    @Published var homeName = ""
    @Published var user: UserProfile?
    @Published var home: HomeProfile?
    @Published var selectedTab: Int = 0
    
    // Loads the currently logged in user when object is initialised
    override init() {
        super.init()
        loadingState = .loading
        Task {
            await loadData()
        }
    }
    
    // Loads currently logged in user and saves homeId to UserDefaults
    // Function is called every time view is initialised
    func loadData() async {
        do {
            let authDataResult = try authManager.getAuthenticatedUser()
            self.user = try await dataStore.userManager.getUser(userId: authDataResult.uid)
            UserDefaults.standard.set(self.user?.userId, forKey: "userId")
            if let homeId = self.user?.homeId {
                self.home = try await dataStore.homeManager.getHome(homeId: homeId)
                updateValues()
                UserDefaults.standard.set(homeId, forKey: "homeId")
            }
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
    }
    
    func updateValues() {
        homeName = self.home?.name ?? ""
    }
}
