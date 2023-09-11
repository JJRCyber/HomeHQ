//
//  NoticeBoardView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticesPageView: View {
    
    // View model initialised
    @StateObject var viewModel = NoticePageViewModel()
    
    // Displays both Notices and WeekPlanner view
    // Sheet is triggered by create notice button
    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                NoticesView(viewModel: viewModel)
                WeekPlannerView(viewModel: viewModel)
                createNoticeButton
            }
            .sheet(isPresented: $viewModel.showAddNoticeSheet) {
                AddNoticeView(viewModel: viewModel)
            }

        }
        }
        
    
    var createNoticeButton: some View {
        Button {
            viewModel.showAddNoticeSheet.toggle()
        } label: {
            Text("Create Notice")
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color("Highlight"))
                .cornerRadius(10)
                .padding()
                .foregroundColor(Color("SecondaryText"))
        }

    }
}

// Custom preview viewModel so can be previewed with tab bar
struct NoticesPageView_Previews: PreviewProvider {
    static var viewModel: TabBarViewModel = {
        let vm = TabBarViewModel()
        vm.selectedTab = 2
        return vm
    }()
    
    static var previews: some View {
        TabBarView(showSignInView: .constant(false), viewModel: viewModel)
    }
}
