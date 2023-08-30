//
//  AuthenticationManager.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation
import FirebaseAuth

// Creating a struct to store only the needed data from the returned Firebase user object
struct AuthDataResultModel {
    let uid: String
    let email: String
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? ""
        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviders: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}


final class AuthenticationManager {

    // Shared instance of class is declared to be used across application
    static let shared = AuthenticationManager()
    private init() { }

    // Try to retrieve the current user from local storage else throw an error
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw ApplicationError.userNotRetrieved
        }

        return AuthDataResultModel(user: user)
    }
    
    func getProviders() throws -> [AuthProviders] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw ApplicationError.userNotRetrieved
        }
        
        var providers: [AuthProviders] = []
        for provider in providerData {
            if let option = AuthProviders(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found \(provider.providerID)")
            }
        }
        
        return providers
    }

    // Signs out the current account
    func signOut() throws {
        try Auth.auth().signOut()
    }
}



// MARK: EMAIL SIGN IN
extension AuthenticationManager {
    
    // Use Firebase to create a new user based on provided email and password
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }

    // Sign in with email and password
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Function to reset password NOT IMPLEMENTED
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}

// MARK: SIGN IN SSO
extension AuthenticationManager {
   
    // Sign in with Google using credential token
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signInWithCredential(credential: credential)
    }
    
    // Sign in with Apple using credential token
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.appleCredential(withIDToken: tokens.idToken,
                                                       rawNonce: tokens.nonce,
                                                       fullName: tokens.fullName)
        return try await signInWithCredential(credential: credential)
    }

    // Sign in with crdential function used with Google
    func signInWithCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
