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
    
    func updateUserDeatils() {
        if var user = self.user {
            user.updateName(name: name)
            user.updateMobile(mobile: mobile)
            user.updateUserName(userName: userName)
        }
    }
    
    // Signs out the currently logged in user
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
