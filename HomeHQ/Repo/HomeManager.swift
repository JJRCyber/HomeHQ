//
//  HomeManager.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 31/8/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeProfile: Codable {
    let homeId: String
    let name: String
    let address: String?
    let owner: String
    let members: [String]
    
    init(homeId: String = UUID().uuidString, name: String, address: String?, owner: String, members: [String] = []) {
        self.homeId = homeId
        self.name = name
        self.address = address
        self.owner = owner
        self.members = members
    }
    
    enum CodingKeys: String, CodingKey {
        case homeId = "home_id"
        case name = "name"
        case address = "address"
        case owner = "owner"
        case members = "members"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.homeId = try container.decode(String.self, forKey: .homeId)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.owner = try container.decode(String.self, forKey: .owner)
        self.members = try container.decode([String].self, forKey: .members)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.homeId, forKey: .homeId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.address, forKey: .address)
        try container.encode(self.owner, forKey: .owner)
        try container.encode(self.members, forKey: .members)
    }
    

}

final class HomeManager {
    static let shared = HomeManager()
    private init() { }
    
    private let homeCollection = Firestore.firestore().collection("homes")
    private let homeId = UserDefaults.standard.string(forKey: "homeId")
    
    private func homeDocument(homeId: String) -> DocumentReference {
        homeCollection.document(homeId)
    }
    
    func getHome(homeId: String) async throws -> HomeProfile {
        try await homeDocument(homeId: homeId).getDocument(as: HomeProfile.self)
    }
    
    func createNewHome(home: HomeProfile) async throws {
        try homeDocument(homeId: home.homeId).setData(from: home, merge: false)
    }
    
    func addHomeMember(homeId: String, userId: String) async throws {
        let data: [String: Any] = [
            HomeProfile.CodingKeys.members.rawValue : FieldValue.arrayUnion([userId])
        ]
        try await homeDocument(homeId: homeId).updateData(data)
    }
    
    func removeHomeMember(homeId: String, userId: String) async throws {
        let data: [String: Any] = [
            HomeProfile.CodingKeys.members.rawValue : FieldValue.arrayRemove([userId])
        ]
        try await homeDocument(homeId: homeId).updateData(data)
    }

}

//MARK: Shopping List
extension HomeManager {
    
    private func shoppingListCollection(homeId: String) -> CollectionReference {
        homeDocument(homeId: homeId).collection("shopping_list")
    }
    
    private func shoppingListCollectionDocument(homeId: String, shoppingListItemId: String) -> DocumentReference {
        shoppingListCollection(homeId: homeId).document(shoppingListItemId)
    }
    
    func getShoppingList(homeId: String) async throws -> [ShoppingListItem] {
        var shoppingList:[ShoppingListItem] = []
        let snapshot = try await shoppingListCollection(homeId: homeId).getDocuments()
        for document in snapshot.documents {
            let shoppingListItem = try document.data(as: ShoppingListItem.self)
            shoppingList.append(shoppingListItem)
        }
        return shoppingList
    }
    
    func addShoppingListItem(homeId: String, shopppingListItem: ShoppingListItem) async throws {
        try shoppingListCollectionDocument(homeId: homeId, shoppingListItemId: shopppingListItem.id).setData(from: shopppingListItem, merge: false)
    }
    
    func removeShoppingListItem(homeId: String, shoppingListItemId: String) async throws {
        try await shoppingListCollectionDocument(homeId: homeId, shoppingListItemId: shoppingListItemId).delete()
    }
    
    func updateShoppingListItem(shoppingListItem: ShoppingListItem) async throws {
        if let homeId {
            try shoppingListCollectionDocument(homeId: homeId, shoppingListItemId: shoppingListItem.id).setData(from: shoppingListItem)
        }
    }
}
