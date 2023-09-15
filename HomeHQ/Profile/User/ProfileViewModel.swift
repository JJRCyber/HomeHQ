//
//  SettingsViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation

// ViewModel for Settings view
@MainActor
final class ProfileViewModel: BaseViewModel {
    
    // UserProfile init as nil before being async loaded from Firestore
    @Published var user: UserProfile? = nil
    
    // Bound to view textfields
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var mobile: String = ""
    

    // Loads current user from Firestore
    func loadCurrentUser() async {
        loadingState = .loading
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            updateValues()
            loadingState = .loaded
        } catch {
            loadingState = .error
            showError = true
            errorMessage = error.localizedDescription
        }

    }
    
    // Updates text fields with values from Firestore user profile
    // If fields are nil replace with empty string
    func updateValues() {
        if let user = self.user {
            name = user.name ?? ""
            userName = user.userName ?? ""
            email = user.email ?? ""
            mobile = user.mobile ?? ""
        }
    }
    
    // Updates user profile in Firestore and displays error if it fails
    func updateUserProfile() {
        guard let user else { return }
        Task {
            do {
                try await UserManager.shared.updateUserProfile(userId: user.userId, userName: userName, name: name, mobile: mobile)
                await loadCurrentUser()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }

        }
    }
    
    // Signs out the currently logged in user
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
