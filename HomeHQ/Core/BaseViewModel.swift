//
//  BaseViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 2/9/2023.
//

import SwiftUI

// Protocol used in all viewModels that can add items to Firestore collection
@MainActor
protocol AddItem {
    func clearInputFields()
    func addItem()
}

// Used in all viewModels that fetch data from Firestore
@MainActor
protocol LoadData {
    func loadData() async
}

// Used in all viewModels that update values after async tasks
@MainActor
protocol UpdateValues {
    func updateValues()
}



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
    var homeId = UserDefaults.standard.string(forKey: "homeId")
    let userId = UserDefaults.standard.string(forKey: "userId")
    
    // Default loading state set to idle
    @Published var loadingState: LoadingState = .idle
    
    // Properties to display alert popup with error message
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
}
