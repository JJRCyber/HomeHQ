//
//  WeekPlannerView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 25/8/2023.
//

import SwiftUI

struct WeekPlannerView: View {
    
    @ObservedObject var viewModel: NoticeBoardViewModel
    
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
        .frame(maxHeight: 300)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct WeekPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerView(viewModel: NoticeBoardViewModel())
    }
}
