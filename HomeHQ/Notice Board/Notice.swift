//
//  NoticeModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation


// Struct for notice
struct Notice: Identifiable, Codable {
    let id: String
    let title: String
    let detail: String
    let date: Date
    let importance: Int
    let user: String
    
    init(id: String = UUID().uuidString, title: String, detail: String, date: Date, importance: Int, user: String = "") {
        self.id = id
        self.title = title
        self.detail = detail
        self.date = date
        self.importance = importance
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case detail = "detail"
        case date = "date"
        case importance = "importance"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.detail = try container.decode(String.self, forKey: .detail)
        self.date = try container.decode(Date.self, forKey: .date)
        self.importance = try container.decode(Int.self, forKey: .importance)
        self.user = try container.decode(String.self, forKey: .user)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.detail, forKey: .detail)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.importance, forKey: .importance)
        try container.encode(self.user, forKey: .user)
    }
}
