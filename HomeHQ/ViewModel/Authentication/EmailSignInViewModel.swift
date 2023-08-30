//
//  EmailSignInViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import Foundation

// View model for EmailSignInView
final class EmailSignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var signUpError = false
    @Published var errorMessage = ""
    @Published var passwordResetError = false
    @Published var passwordResetSuccess = false
    @Published var passwordResetErrorMessage = ""
    @Published var showForgotPasswordView = false
    
    
    // Function to sign in user given email and password
    func signIn(email: String, password: String) async throws {

        // Check if email or password field is empty
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }

        // Try to sign in user with given email and password
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
