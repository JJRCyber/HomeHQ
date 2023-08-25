//
//  NoticeBoardViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation

struct Notice: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let date: Date
    let importance: Int
    let user: String
}

class NoticeBoardViewModel: ObservableObject {
    
    @Published var notices: [Notice] = []
    
    var upcomingWeek: [Date] {
        var dates: [Date] = []
        
        for index in 0..<7 {
            if let date = Calendar.current.date(byAdding: .day, value: index, to: Date()) {
                dates.append(date)
            }
        }

        return dates
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Day of the week
        return formatter
    }()
    
    func formatDayOfWeek(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func addNotice() {
        let notice1 = Notice(title: "Electrician coming today", detail: "Should be coming between 1 - 2pm, changing lights", date: Date(), importance: 4, user: "Cooper")
        let notice2 = Notice(title: "Internet is slow today", detail: "Should be fixed tomorrow", date: Date(), importance: 3, user: "Amelia")
        
        notices.append(notice1)
        notices.append(notice2)
    }
    
    
}
