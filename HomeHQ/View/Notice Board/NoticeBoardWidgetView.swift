//
//  NoticeBoardWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticeBoardWidgetView: View {
    
    @StateObject var viewModel = NoticeBoardViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("Notices")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            List {
                ForEach(viewModel.notices) { notice in
                    NoticeWidgetRowView(notice: notice)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            Spacer()
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .shadow(color: Color("AccentColor"), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
}

struct NoticeBoardWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeBoardWidgetView()
    }
}
