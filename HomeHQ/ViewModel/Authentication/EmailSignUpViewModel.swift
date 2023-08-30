//
//  EmailSignUpViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//


// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import Foundation


final class EmailSignUpViewModel: ObservableObject {
    
    // Variables for email, password and error handling
    @Published var email = ""
    @Published var password = ""
    @Published var passwordCheck = ""
    @Published var signUpError = false
    @Published var errorMessage = ""

    
    
    
    func signUp(email: String, password: String, passwordCheck: String) async throws {

        // Input validation that throws errors if it fails

        // Check if email or password field empty
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }

        // Password validation to check passwords match
        guard password == passwordCheck else {
            throw SignInErrors.passwordsDontMatch("Passwords do not match")
        }

        // Try to create user with given email and password
        let authDatResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
//        let user = UserProfile(auth: authDatResult)
//        try await UserManager.shared.createNewUser(user: user)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        // Check for length
        guard password.count > 6 else { return false }

        // Check for uppercase character
        let uppercaseCharacterRegex = "[A-Z]"
        let uppercaseCharacterPredicate = NSPredicate(format:"SELF MATCHES %@", uppercaseCharacterRegex)
        let containsUppercaseCharacter = password.range(of: uppercaseCharacterRegex, options: .regularExpression) != nil

        return containsUppercaseCharacter
    }
    
    func passwordsMatch(password: String, passwordCheck: String) -> Bool {
        return password == passwordCheck
    }

}
