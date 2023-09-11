//
//  Datastore.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 2/9/2023.
//

import Foundation

final class DataStore {
    
    // Single point of entry for both HomeManager and UserManager
    static let shared = DataStore()
    private init() { }
    
    let userManager = UserManager.shared
    let homeManager = HomeManager.shared
    
}
