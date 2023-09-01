//
//  BaseViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 2/9/2023.
//

import SwiftUI

open class BaseViewModel: ObservableObject {
    let authManager = AuthenticationManager.shared
    let dataStore = DataStore.shared
    
    @AppStorage("homeId") var homeId = ""
    
}
