//
//  NoticeRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct NoticesWidgetRowView: View {
    
    let notice: Notice
    
    // Row view for notice widget
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

struct NoticesWidgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesWidgetRowView(notice: Notice(title: "Shower is broken", detail: "", date: Date(), importance: 4, user: "Cooper"))
    }
}
