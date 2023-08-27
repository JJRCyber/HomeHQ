//
//  NoticeBoardView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticeBoardView: View {
    
    // View model initialised
    @StateObject var viewModel = NoticeBoardViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            BulletinView(viewModel: viewModel)
                .shadow(color: Color("AccentColor"), radius: 5)
            WeekPlannerView(viewModel: viewModel)
                .shadow(color: Color("AccentColor"), radius: 5)
            createNoticeButton
        }
        .sheet(isPresented: $viewModel.showAddNoticeSheet) {
            AddNoticeView(viewModel: viewModel)
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
                .shadow(color: Color("AccentColor"), radius: 5, x: 0, y: 5)
                .padding()
                .foregroundColor(Color("SecondaryText"))
        }

    }
}

struct NoticeBoardView_Previews: PreviewProvider {
    static var viewModel: TabBarViewModel = {
        let vm = TabBarViewModel()
        vm.selectedTab = 2
        return vm
    }()
    
    static var previews: some View {
        TabBarView(showSignInView: .constant(false), viewModel: viewModel)
    }
}
