//
//  NoticeRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticeRowView: View {
    
    let notice: Notice
    
    var body: some View {
        HStack() {
            // Need to change to snapshot taken when map is downloaded
            Image("Example")
                .resizable()
                .frame(width: 100, height: 100)
                .clipped()
            Spacer()
            VStack(alignment: .leading,  spacing: 3) {
                Text(notice.title)
                    .font(.callout)
                    .foregroundColor(Color("PrimaryText"))
                    .padding(.top, 3)
                Text(notice.detail)
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing)
                Spacer()
                HStack {
                    ImportanceView(importance: notice.importance)
                    Spacer()
                    Text(notice.user)
                        .font(.caption2)
                }
                .padding(.bottom, 5)
                .padding(.trailing)
            }
        }
        
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 100)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(radius: 5, y: 5)
    }
}

struct NoticeRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRowView(notice: Notice(title: "Shower is broken", detail: "The hot water is not working properly and needs to be fixed", date: Date(), importance: 4, user: "Cooper"))
    }
}
