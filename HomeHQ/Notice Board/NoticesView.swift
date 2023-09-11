//
//  BulletinView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct NoticesView: View {
    
    @ObservedObject var viewModel: NoticePageViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            title
            Divider()
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                if !viewModel.notices.isEmpty {
                    List {
                        ForEach(viewModel.notices) { notice in
                            NoticesRowView(notice: notice)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: viewModel.deleteNotice)
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text("No Notices!")
                        .font(.headline)
                        .foregroundColor(Color("PrimaryText"))
                    Spacer()
                }
            case .error:
                MissingHomeView()
            }


        }
        .task {
            await viewModel.loadNotices()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .frame(maxHeight: 250)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding()
    }
    
    var title: some View {
        Text("Notices")
            .foregroundColor(Color("PrimaryText"))
            .padding(.vertical)
    }
}

struct NoticesView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesView(viewModel: NoticePageViewModel())
    }
}
