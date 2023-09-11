//
//  NoticeBoardWidgetViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import Foundation

@MainActor
final class NoticeWidgetViewModel: BaseViewModel {
    @Published var notices: [Notice] = []
    
    func loadNotices() async {
        loadingState = .loading
        do {
            self.notices = try await dataStore.homeManager.getNotices()
            loadingState = .loaded
        } catch {
            loadingState = .error
        }
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
}
