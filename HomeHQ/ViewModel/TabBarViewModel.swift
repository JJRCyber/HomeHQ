//
//  TabBarViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

// View model for Tab + Top bar view
final class TabBarViewModel: ObservableObject {
    
    @Published var homeName = "Rickard Street"
    @Published var selectedTab: Int = 0
    
}
