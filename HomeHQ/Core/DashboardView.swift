//
//  DashboardView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    
    // Displays simplified widget views of different app screens
    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
            ScrollView {
                VStack(spacing: 20) {
                    NoticesWidgetView()
                        .onTapGesture {
                            tabBarViewModel.selectedTab = 2
                        }
                    HStack(spacing: 15) {
                        RemindersWidgetView()
                            .onTapGesture {
                                tabBarViewModel.selectedTab = 3
                            }
                        ShoppingListWidgetView()
                            .onTapGesture {
                                tabBarViewModel.selectedTab = 3
                            }
                    }
                    BillWidgetView()
                        .onTapGesture {
                            tabBarViewModel.selectedTab = 1
                        }
                    HouseDutiesWidgetView()
                        .onTapGesture {
                            tabBarViewModel.selectedTab = 4
                        }
                }
                .padding(.top)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(showSignInView: .constant(false))
    }
}
