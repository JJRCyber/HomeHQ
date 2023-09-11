//
//  TabBarView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct TabBarView: View {


    @Binding var showSignInView: Bool
    @StateObject var viewModel = TabBarViewModel()

    // Tab and header bar that are seen through all tab pages
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(viewModel.homeName)
                        .padding()
                    Spacer()
                    Image(systemName: "house.fill")
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .padding()
                    }
                }
                .background(Color("AlternateBackground"))
                .font(.title)
                .foregroundColor(Color("PrimaryText"))
                switch(viewModel.loadingState) {
                case .loading, .idle:
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .loaded:
                    TabView(selection: $viewModel.selectedTab) {
                        Group {
                            DashboardView()
                                .tabItem {
                                    Image(systemName: "square.grid.2x2")
                                    Text("Dashboard")                        }
                                .tag(0)
                            BillView()
                                .tabItem {
                                    Image(systemName: "dollarsign.circle.fill")
                                    Text("Costs")
                                }
                                .tag(1)
                            NoticesPageView()
                                .tabItem {
                                    Image(systemName: "list.clipboard.fill")
                                    Text("Notice Board")
                                }
                                .tag(2)
                            RemindersView()
                                .tabItem {
                                    Image(systemName: "checklist")
                                    Text("Reminders")
                                }
                                .tag(3)
                            HouseDutiesView()
                                .tabItem {
                                    Image(systemName: "house.fill")
                                    Text("Duties")
                                }
                                .tag(4)
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .font(.headline)
                        }
                case .error:
                    VStack {
                        Spacer()
                        Image(systemName: "hazardsign.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Error loading home")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Spacer()
                    }

                    
                }
            }
        .environmentObject(viewModel)
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(showSignInView: .constant(false))
    }
}
