//
//  NoticeRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticesRowView: View {
    
    let notice: Notice
    
    var body: some View {
        HStack() {
            Image("Example")
                .resizable()
                .frame(width: 100, height: 100)
                .clipped()
            Spacer()
            VStack(alignment: .leading,  spacing: 3) {
                title
                detail
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
    }
    
    var title: some View {
        Text(notice.title)
            .font(.callout)
            .foregroundColor(Color("PrimaryText"))
            .padding(.top, 3)
    }
    
    var detail: some View {
        Text(notice.detail)
            .font(.caption2)
            .multilineTextAlignment(.leading)
            .padding(.trailing)
    }
}

struct NoticesRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesRowView(notice: Notice(title: "Shower is broken", detail: "The hot water is not working properly and needs to be fixed", date: Date(), importance: 4, user: "Cooper"))
    }
}
