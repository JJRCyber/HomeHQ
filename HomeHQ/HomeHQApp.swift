//
//  HomeHQApp.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

@main
struct HomeHQApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView(showSignInView: .constant(false))
        }
    }
}
