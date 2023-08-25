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
            Text("Bulletins")
                .foregroundColor(Color("PrimaryText"))
                .padding(.vertical)
            Divider()
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.notices) { notice in
                        NoticeRowView(notice: notice)
                        Divider()
                    }
                }

            }
        }
        .frame(maxHeight: 250)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding()
        
        .onAppear {
            viewModel.addNotice()
        }
    }
}

struct BulletinView_Previews: PreviewProvider {
    static var previews: some View {
        BulletinView(viewModel: NoticeBoardViewModel())
    }
}
