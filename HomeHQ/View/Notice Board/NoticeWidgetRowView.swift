//
//  NoticeRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticeWidgetRowView: View {
    
    let notice: Notice
    
    var body: some View {
        HStack {
            Text(notice.title)
                .font(.footnote)
            Spacer()
            Text(notice.date.formatted(date: .abbreviated, time: .omitted))
                .font(.footnote)
        }
    }
}

struct NoticeWidgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeWidgetRowView(notice: Notice(title: "Shower is broken", detail: "", date: Date(), importance: 4, user: "Cooper"))
    }
}
