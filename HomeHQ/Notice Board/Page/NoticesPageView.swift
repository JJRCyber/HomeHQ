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
            }
            .sheet(isPresented: $viewModel.showAddNoticeSheet) {
                AddNoticeView(viewModel: viewModel)
            }
            
        }
    }
}

// Custom preview viewModel so can be previewed with tab bar
struct NoticesPageView_Previews: PreviewProvider {
    static var viewModel: NoticePageViewModel = {
        let vm = NoticePageViewModel()
        vm.notices = [
            Notice(title: "Testing", detail: "", date: Date(), importance: 3)
        ]
        vm.loadingState = .loaded
        return vm
    }()
    
    static var previews: some View {
        NoticesPageView(viewModel: viewModel)
    }
}
