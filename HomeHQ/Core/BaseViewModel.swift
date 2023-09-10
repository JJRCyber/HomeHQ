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
        case error(Error)
    }
    
    let authManager = AuthenticationManager.shared
    let dataStore = DataStore.shared
    let homeId = UserDefaults.standard.string(forKey: "homeId")
    
}
