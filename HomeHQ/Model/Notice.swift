//
//  NoticeModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation


// Struct for notice
struct Notice: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let date: Date
    let importance: Int
    let user: String
}
