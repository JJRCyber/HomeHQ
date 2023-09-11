//
//  BaseViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 2/9/2023.
//

import SwiftUI

open class BaseViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case error
    }
    
    let authManager = AuthenticationManager.shared
    let dataStore = DataStore.shared
    let homeId = UserDefaults.standard.string(forKey: "homeId")
    @Published var loadingState: LoadingState = .idle
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
}
