//
//  HomeProfileViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import Foundation

final class HomeProfileViewModel: BaseViewModel {
    
    @Published var home: HomeProfile? = nil
    
    @Published var name: String = ""
    @Published var address: String = ""
    
    // Shows sheet to join a new home
    @Published var showJoinHomeSheet: Bool = false
    // Bound to text field in displayed
    @Published var homeIdText: String = ""
    
    func joinHome() {
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        
        Task {
            do {
                try await dataStore.homeManager.addHomeMember(homeId: homeIdText, userId: userId)
                try await dataStore.userManager.updateHomeId(userId: userId, homeId: homeIdText)
                self.home = try await dataStore.homeManager.getHome(homeId: homeIdText)
            } catch {
                showError = true
                errorMessage = "Could not add user to home"
            }
        }
    }
    
    // Creates a new home with some default values
    func createHome() {
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        let members = [userId]
        let home = HomeProfile(name: name, address: address, owner: userId, members: members)
        Task {
            do {
                try await dataStore.homeManager.createNewHome(home: home)
                try await dataStore.userManager.updateHomeId(userId: userId, homeId: home.homeId)
                self.home = try await dataStore.homeManager.getHome(homeId: home.homeId)
            } catch {
                showError = true
                errorMessage = "Failed to create home"
            }
        }
    }
}
