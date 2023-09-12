//
//  BulletinView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct NoticesView: View {
    
    @ObservedObject var viewModel: NoticePageViewModel
    
    // Displays notices and information about them
    var body: some View {
        VStack(spacing: 0) {
            headerBar
            Divider()
            
            // Switch based on loading state
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                // Displays notices if any notices
                // or displays prompt if notices empty
                if !viewModel.notices.isEmpty {
                    List {
                        ForEach(viewModel.notices) { notice in
                            NoticesRowView(notice: notice)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                        // Allows for swiping to delete action
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
    
    // Header bar that contains add button and title
    // Always shown in view regardless of loading state
    var headerBar: some View {
        HStack {
            Spacer()
            Text("Notices")
                .foregroundColor(Color("PrimaryText"))
                .padding(.vertical)
                .padding(.leading)
            Spacer()
            Button {
                viewModel.showAddNoticeSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(Color("PrimaryText"))

            }
        }
        .padding(.horizontal)
    }
}

struct NoticesView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesView(viewModel: NoticePageViewModel())
    }
}
