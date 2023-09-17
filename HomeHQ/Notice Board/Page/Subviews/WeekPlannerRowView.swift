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
    
    // Row view for week planner
    // Displays a circle on each day if a notice occurs
    var body: some View {
        HStack {
            Text(viewModel.formatDayOfWeek(date: date))
                .foregroundColor(Color("PrimaryText"))
                .frame(width: 100)
                .padding()
            Divider()
            if viewModel.dayHasNotice(for: date) {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color("Highlight"))
            }
            Spacer()
        }
        .frame(height: 40)
    }
}

struct WeekPlannerRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerRowView(viewModel: NoticePageViewModel(), date: Date())
    }
}
