//
//  NoticeBoardWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticesWidgetView: View {
    
    @StateObject var viewModel = NoticeWidgetViewModel()
    
    // Notice widget view that is seen on dashboard
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("Notices ‼️")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            
            // Switch on view model loading state 
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                if !viewModel.notices.isEmpty {
                    List {
                        ForEach(viewModel.notices) { notice in
                            NoticesWidgetRowView(notice: notice)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    Spacer()
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
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
}

struct NoticesWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesWidgetView()
    }
}
