//
//  DashboardView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
            ScrollView {
                VStack(spacing: 20) {
                    NoticeBoardWidgetView()
                    RemindersWidgetView()
                    BillWidgetView()
                    HouseDutiesWidgetView()
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
