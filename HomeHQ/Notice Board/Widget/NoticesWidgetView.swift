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
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                List {
                    ForEach(viewModel.notices) { notice in
                        NoticesWidgetRowView(notice: notice)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                Spacer()
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
