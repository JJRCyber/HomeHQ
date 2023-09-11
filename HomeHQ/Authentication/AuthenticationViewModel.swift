//
//  AuthenticationViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation
import CryptoKit
import AuthenticationServices

// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT
/// Defines SSO sign in functions for both Google + Apple
/// Requires helper classes that are completely decoupled
/// Firestore implementation currently not functional
@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // Variables to show alerts if sign in fails
    @Published var signInError = false
    @Published var errorText = ""
    
    // Launches Google Sign In pop up and create news document for user if sign-in successful
    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signInGoogle()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = UserProfile(auth: authDataResult)
        let userDocument = try? await UserManager.shared.getUser(userId: user.userId)
        if userDocument == nil {
            try await UserManager.shared.createNewUser(user: user)
        }
    }
    
    // Launches Apple Sign In dialog and then signs user in through Firebase Auth
    func signInApple() async throws {
        let helper = AppleSignInHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let user = UserProfile(auth: authDataResult)
        let userDocument = try? await UserManager.shared.getUser(userId: user.userId)
        if userDocument == nil {
            try await UserManager.shared.createNewUser(user: user)
        }
    }
    
    
    
    
}
