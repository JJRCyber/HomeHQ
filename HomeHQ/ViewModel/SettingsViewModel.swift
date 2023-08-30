//
//  SettingsViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation

// ViewModel for Settings view
final class SettingsViewModel: ObservableObject {
    
    // Signs out the currently logged in user
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
