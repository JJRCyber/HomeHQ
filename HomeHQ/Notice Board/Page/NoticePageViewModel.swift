//
//  NoticeBoardViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import Foundation
import SwiftUI

// View Model for notice board view and subviews
@MainActor
class NoticePageViewModel: BaseViewModel {
    
    // Stores array of notices that is displayed on view
    // Currently does not persist will add persistence later
    @Published var notices: [Notice] = []
    
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
    
    // Loads notice from Firestore
    func loadNotices() async {
        loadingState = .loading
        do {
            self.notices = try await dataStore.homeManager.getNotices()
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
    }
    
    // Function to return day string when given a date
    func formatDayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    // 1. Adds a new notice to Firestore
    // 2. Dismisses the create notice view
    // 3. Clears all fields associated with create notice view
    func addNotice() {
        let notice = Notice(title: noticeTitle, detail: noticeDescription, date: noticeDate, importance: noticeImportance, user: "Cooper")
        Task {
            do {
                try await dataStore.homeManager.addNotice(notice: notice)
                await loadNotices()
                showAddNoticeSheet.toggle()
                clearAddNoticeFields()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Clears all bound values for add notice fields
    private func clearAddNoticeFields() {
        noticeTitle = ""
        noticeDescription = ""
        noticeImportance = 1
        noticeDate = Date()
    }
    
    // Deletes notice at given index
    func deleteNotice(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let noticeId = notices[index].id
        notices.remove(atOffsets: offsets)
        Task {
            do {
                try await dataStore.homeManager.removeNotice(noticeId: noticeId)
                await loadNotices()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Checks if a day has a notice on it and returns true if it does
    // Used to know if a circle should be added to week planner view row
    func dayHasNotice(for date: Date) -> Bool {
        let calendar = Calendar.current
        return notices.contains { notice in
            calendar.isDate(notice.date, inSameDayAs: date)
        }
    }
    
    
}
