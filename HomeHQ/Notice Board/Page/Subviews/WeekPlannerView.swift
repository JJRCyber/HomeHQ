//
//  WeekPlannerView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct WeekPlannerView: View {
    
    @ObservedObject var viewModel: NoticePageViewModel
    
    // Week planner view that shows the next 7 days
    // Displays circle on days that have a notice
    // Not fully implemented
    var body: some View {
        VStack {
            Text("Upcoming Week")
                .foregroundColor(Color("PrimaryText"))
                .padding(.top)
            Divider()
            ScrollView {
                ForEach(viewModel.upcomingWeek, id: \.self) { date in
                    WeekPlannerRowView(viewModel: viewModel, date: date)
                    Divider()
                }
            }

        }
        .frame(maxHeight: 450)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct WeekPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerView(viewModel: NoticePageViewModel())
    }
}
