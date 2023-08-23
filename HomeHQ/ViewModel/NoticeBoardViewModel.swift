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
}

class NoticeBoardViewModel: ObservableObject {
    @Published var notices: [Notice] = []
    
    func addNotice() {
        let notice1 = Notice(title: "Shower isn't working", detail: "Shower needs to be fixed don't use until 08/23", date: Date())
        let notice2 = Notice(title: "Internet is slow today", detail: "Should be fixed tomorrow", date: Date())
        
        notices.append(notice1)
        notices.append(notice2)
    }
    
    
}
