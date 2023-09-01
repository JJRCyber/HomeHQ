//
//  GoogleSignInHelper.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//


// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import Foundation
import GoogleSignIn
import GoogleSignInSwift

// Custom model with information returned from Google Sign in dialog
struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}


// Helper class for Google Signin
final class GoogleSignInHelper {

    // This function must run on main thread as it needs access to View
    @MainActor
    func signInGoogle() async throws -> GoogleSignInResultModel {

        // Get the top VC (Firebase does not have full SwiftUI support yet)
        guard let topVC = ViewUtils.shared.topViewController() else {
            throw ApplicationError.cannotGetTopView
        }

        // Get the sign in result object from opened dialog
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

        // Set idToken from signinresult
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            // FIXME: Should throw custom error
            throw SignInErrors.googleSignInError("Cannot retrieve sign in token")
        }

        // Set variables for access tokens and name + email
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.givenName
        let email = gidSignInResult.user.profile?.email

        // Returns tokens as a GoogleSignInResultModel struct
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
}
