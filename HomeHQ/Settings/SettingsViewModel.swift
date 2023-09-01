//
//  SettingsViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation

// ViewModel for Settings view
@MainActor
final class SettingsViewModel: ObservableObject {
    
//    @Published private(set) var user: UserProfile? = nil
    @Published var user: UserProfile? = nil
    
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var mobile: String = ""
    
    @Published var showJoinHomeSheet: Bool = false
    @Published var homeId: String = ""
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func updateValues() {
        if let user = self.user {
            name = user.name ?? ""
            userName = user.userName ?? ""
            email = user.email ?? ""
            mobile = user.mobile ?? ""
        }
    }
    
    func updateName() {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateName(userId: user.userId, name:name)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func updateHomeId() {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateName(userId: user.userId, name:name)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func createHome() {
        guard let user else { return }
        let members = [user.userId]
        let home = HomeProfile(name: "Rickard St", address: nil, owner: user.userId, members: members)
        Task {
            try await HomeManager.shared.createNewHome(home: home)
            try await UserManager.shared.updateHomeId(userId: user.userId, homeId: home.homeId)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func joinHome() {
        guard let user else { return }
        Task {
            try await HomeManager.shared.addHomeMember(homeId: homeId, userId: user.userId)
            try await UserManager.shared.updateHomeId(userId: user.userId, homeId: homeId)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    // Signs out the currently logged in user
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
