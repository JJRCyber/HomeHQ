//
//  UserManager.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile: Codable {
    let userId: String
    let userName: String?
    let email: String?
    let mobile: String?
    let name: String?
    let birthday: Date?
    let photoUrl: String?
    let dateCreated: Date?
    let homeId: String?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.userName = nil
        self.email = auth.email
        self.mobile = nil
        self.name = nil
        self.birthday = nil
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.homeId = nil
    }
    
    init(
        userId: String,
        userName: String? = nil,
        email: String? = nil,
        mobile: String? = nil,
        name: String? = nil,
        birthday: Date? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        homeId: String? = nil
    ) {
        self.userId = userId
        self.userName = userName
        self.email = email
        self.mobile = mobile
        self.name = name
        self.birthday = birthday
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.homeId = homeId
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userName = "user_name"
        case email = "email"
        case mobile = "mobile"
        case name = "name"
        case birthday = "birthday"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case homeId = "home_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.birthday = try container.decodeIfPresent(Date.self, forKey: .birthday)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.homeId = try container.decodeIfPresent(String.self, forKey: .homeId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.userName, forKey: .userName)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.mobile, forKey: .mobile)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.birthday, forKey: .birthday)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.homeId, forKey: .homeId)
    }
    

    
//    mutating func updateName(name: String) {
//        self.name = name
//    }
}


final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: UserProfile) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> UserProfile {
        try await userDocument(userId: userId).getDocument(as: UserProfile.self)
    }
    
    func getCurrentUser() async throws -> UserProfile {
        let userId = try AuthenticationManager.shared.getAuthenticatedUser().uid
        let userProfile = try await getUser(userId: userId)
        return userProfile
    }
    
    func updateName(userId: String, name: String) async throws {
        let data: [String:Any] = [
            UserProfile.CodingKeys.name.rawValue : name
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateHomeId(userId: String, homeId: String) async throws {
        let data: [String:Any] = [
            UserProfile.CodingKeys.homeId.rawValue : homeId
        ]
        try await userDocument(userId: userId).updateData(data)
        UserDefaults.standard.set(homeId, forKey: "homeId")
    }

    
    
    
    
}
