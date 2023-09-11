//
//  BaseViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 2/9/2023.
//

import SwiftUI

// Base viewModel that all viewModels inherit from
open class BaseViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case error
    }
    
    // Properties for repo
    let authManager = AuthenticationManager.shared
    let dataStore = DataStore.shared
    
    // Retrieve homeId from UserDefaults
    let homeId = UserDefaults.standard.string(forKey: "homeId")
    let userId = UserDefaults.standard.string(forKey: "userId")
    
    // Default loading state set to idle
    @Published var loadingState: LoadingState = .idle
    
    // Properties to display alert popup with error message
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
}
