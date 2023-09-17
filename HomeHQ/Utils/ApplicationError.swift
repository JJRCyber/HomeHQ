//
//  ApplicationError.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation


// Custom application errors
enum ApplicationError: Error {
    case userNotRetrieved
    case cannotGetTopView
    case homeIdNotRetrieved
}

// Custom errors for sign in and sign up functions
enum SignInErrors: LocalizedError {
    case fieldsNotComplete(String)
    case passwordsDontMatch(String)
    case googleSignInError(String)
    case AppleSignInError(String)
    
    var errorDescription: String? {
        switch self {
        case .fieldsNotComplete(let message):
            return message
        case .passwordsDontMatch(let message):
            return message
        case .googleSignInError(let message):
            return message
        case .AppleSignInError(let message):
            return message
        }
        
    }
}
