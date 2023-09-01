//
//  WeekPlannerRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct WeekPlannerRowView: View {
    
    @ObservedObject var viewModel: NoticePageViewModel
    
    var date: Date
    
    var body: some View {
        HStack {
            Text(viewModel.formatDayOfWeek(date: date))
                .foregroundColor(Color("PrimaryText"))
                .frame(width: 100)
                .padding()
            Divider()
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.horizontal)
        }
        .frame(height: 40)
    }
}

struct WeekPlannerRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerRowView(viewModel: NoticePageViewModel(), date: Date())
    }
}
