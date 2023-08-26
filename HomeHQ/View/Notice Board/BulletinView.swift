//
//  BulletinView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct BulletinView: View {
    
    @ObservedObject var viewModel: NoticeBoardViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Notices")
                .foregroundColor(Color("PrimaryText"))
                .padding(.vertical)
            Divider()
            if !viewModel.notices.isEmpty {
                List {
                    ForEach(viewModel.notices) { notice in
                        NoticeRowView(notice: notice)
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

        }
        .frame(maxHeight: 250)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding()
    }
}

struct BulletinView_Previews: PreviewProvider {
    static var previews: some View {
        BulletinView(viewModel: NoticeBoardViewModel())
    }
}
