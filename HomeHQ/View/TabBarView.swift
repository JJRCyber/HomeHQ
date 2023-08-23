//
//  TabBarView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct TabBarView: View {

    @State var selectedTab: Int = 0
    @Binding var showSignInView: Bool
    @StateObject var viewModel = TabBarViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text(viewModel.homeName)
                        .padding()
                    Spacer()
                    Image(systemName: "house.fill")
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .padding()
                    }
                }
                .background(Color("AlternateBackground"))
                .font(.title)
                .foregroundColor(Color("PrimaryText"))
                TabView(selection: $selectedTab) {
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
                        NoticeBoardView()
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
            }
        }
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(showSignInView: .constant(false))
    }
}
