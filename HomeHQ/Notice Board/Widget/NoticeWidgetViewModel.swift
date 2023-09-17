//
//  NoticeBoardWidgetViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import Foundation

@MainActor
final class NoticeWidgetViewModel: BaseViewModel, LoadData {
    @Published var notices: [Notice] = []
    
    // Loads notices from Firestore
    func loadData() async {
        loadingState = .loading
        do {
            self.notices = try await dataStore.homeManager.getNotices()
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
    }
    
    // Deletes notice at given offset
    // Delete locally and then syncs this change with Firestore
    // Displays alert popup if operation fails
    func deleteNotice(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let noticeId = notices[index].id
        notices.remove(atOffsets: offsets)
        Task {
            do {
                try await dataStore.homeManager.removeNotice(noticeId: noticeId)
                await loadData()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
}
