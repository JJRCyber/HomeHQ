//
//  NoticeBoardViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation
import SwiftUI

// Struct for notice
struct Notice: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let date: Date
    let importance: Int
    let user: String
}

// View Model for notice board view and subviews
class NoticeBoardViewModel: ObservableObject {
    
    // Stores array of notices that is displayed on view
    // Currently does not persist will add persistence later
    @Published var notices: [Notice] = [
        Notice(title: "Test", detail: "Test", date: Date(), importance: 3, user: "Cooper")
    ]
    
    // Is toggled when "Add Notice" button is pressed
    @Published var showAddNoticeSheet: Bool = false
    
    // Bindings to store data entered when creating new notice
    @Published var noticeTitle: String = ""
    @Published var noticeDescription: String = ""
    @Published var noticeDate: Date = Date()
    @Published var noticeImportance: Int = 1
    
    // Adds next 7 calendar dates to an array
    var upcomingWeek: [Date] {
        var dates: [Date] = []
        for index in 0..<7 {
            if let date = Calendar.current.date(byAdding: .day, value: index, to: Date()) {
                dates.append(date)
            }
        }
        return dates
    }
    
    // Function to return day string when given a date
    func formatDayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    // 1. Adds a new notice to notice array
    // 2. Dismisses the create notice view
    // 3. Clears all fields associated with create notice view
    func addNotice() {
        let notice = Notice(title: noticeTitle, detail: noticeDescription, date: noticeDate, importance: noticeImportance, user: "Cooper")
        notices.append(notice)
        showAddNoticeSheet.toggle()
        clearAddNoticeFields()
    }
    
    // Clears all bound values for add notice fields
    func clearAddNoticeFields() {
        noticeTitle = ""
        noticeDescription = ""
        noticeImportance = 1
        noticeDate = Date()
    }
    
    
}
