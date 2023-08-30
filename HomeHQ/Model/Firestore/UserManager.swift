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
    var userName: String?
    let email: String?
    var mobile: String?
    var name: String?
    var birthday: Date?
    let photoUrl: String?
    let dateCreated: Date?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.userName = nil
        self.email = auth.email
        self.mobile = nil
        self.name = nil
        self.birthday = nil
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
    }
    
    init(
        userId: String,
        userName: String? = nil,
        email: String? = nil,
        mobile: String? = nil,
        name: String? = nil,
        birthday: Date? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.userId = userId
        self.userName = userName
        self.email = email
        self.mobile = mobile
        self.name = name
        self.birthday = birthday
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
    }
    
    mutating func updateName(name: String) {
        self.name = name
    }
    
    mutating func updateMobile(mobile: String) {
        self.mobile = mobile
    }
    
    mutating func updateUserName(userName: String) {
        self.userName = userName
    }
}


final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: UserProfile) async throws {
        try userDocument(userId: user.userId).setData(from: user, encoder: encoder)
    }
    
    func getUser(userId: String) async throws -> UserProfile {
        try await userDocument(userId: userId).getDocument(as: UserProfile.self, decoder: decoder)
    }
    
    func updateUser(user: UserProfile) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)
    }
    
    
    
}
