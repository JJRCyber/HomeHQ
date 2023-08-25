//
//  NoticeBoardView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticeBoardView: View {
    
    @StateObject var viewModel = NoticeBoardViewModel()
    var body: some View {
        VStack() {

            ScrollView {
                ForEach(viewModel.notices) { notice in
                    NoticeRowView(notice: notice)
                        .padding(.top)
                }
            }
            .frame(height: 380)
            .cornerRadius(10)
            Spacer()
            Button {
                
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
        .onAppear {
            viewModel.addNotice()
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
