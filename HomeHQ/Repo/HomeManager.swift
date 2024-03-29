//
//  HomeManager.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 31/8/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: HomeProfile Struct
struct HomeProfile: Codable {
    let homeId: String
    let name: String
    let address: String?
    let owner: String
    let members: [String]
    
    // Init from passed values
    init(homeId: String = UUID().uuidString, name: String, address: String?, owner: String, members: [String] = []) {
        self.homeId = homeId
        self.name = name
        self.address = address
        self.owner = owner
        self.members = members
    }
    
    // Coding keys to snake case for Firestore
    enum CodingKeys: String, CodingKey {
        case homeId = "home_id"
        case name = "name"
        case address = "address"
        case owner = "owner"
        case members = "members"
    }
    
    // Decodes from Firestore document to HomeProfile object
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.homeId = try container.decode(String.self, forKey: .homeId)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.owner = try container.decode(String.self, forKey: .owner)
        self.members = try container.decode([String].self, forKey: .members)
    }
    
    // Encodes from HomeProfile to Firestore document
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.homeId, forKey: .homeId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.address, forKey: .address)
        try container.encode(self.owner, forKey: .owner)
        try container.encode(self.members, forKey: .members)
    }
}

//MARK: Home
final class HomeManager {
    
    // Enum for collection type for function reuse
    enum CollectionType: String {
        case shoppingList = "shopping_list"
        case notices = "notices"
    }
    
    // Singleton pattern - Single Source of Truth
    static let shared = HomeManager()
    private init() { }
    
    // Sets homeCollection to Firestore path
    private let homeCollection = Firestore.firestore().collection("homes")
    
    // Returns home document for given homeId
    private func homeDocument(homeId: String) -> DocumentReference {
        homeCollection.document(homeId)
    }
    
    // Get subcollection based on CollectionType parameter
    // Throws custom error if not retrieved
    private func subCollection(collectionType: CollectionType) throws -> CollectionReference {
        guard let homeId = UserDefaults.standard.string(forKey: "homeId") else { throw ApplicationError.homeIdNotRetrieved }
        return homeDocument(homeId: homeId).collection(collectionType.rawValue)
    }
    
    // Returns HomeProfile when given a homeId
    func getHome(homeId: String) async throws -> HomeProfile {
        try await homeDocument(homeId: homeId).getDocument(as: HomeProfile.self)
    }
    
    // Creates a new home document in Firestore
    func createNewHome(home: HomeProfile) async throws {
        try homeDocument(homeId: home.homeId).setData(from: home, merge: false)
    }
    
    // Adds home member to home document in Firestore
    func addHomeMember(homeId: String, userId: String) async throws {
        let data: [String: Any] = [
            HomeProfile.CodingKeys.members.rawValue : FieldValue.arrayUnion([userId])
        ]
        try await homeDocument(homeId: homeId).updateData(data)
    }
    
    func updateHomeName(homeId: String, homeName: String) async throws {
        let data: [String: Any] = [
            HomeProfile.CodingKeys.name.rawValue : homeName
        ]
        try await homeDocument(homeId: homeId).updateData(data)
    }
    
    // Removes home member from given home
    func removeHomeMember(homeId: String, userId: String) async throws {
        let data: [String: Any] = [
            HomeProfile.CodingKeys.members.rawValue : FieldValue.arrayRemove([userId])
        ]
        try await homeDocument(homeId: homeId).updateData(data)
        try await UserManager.shared.removeHomeId(userId: userId)
    }
    
}

//MARK: Shopping List
extension HomeManager {
    
    // Returns shoppingList firestore document
    private func shoppingListCollectionDocument(shoppingListItemId: String) throws -> DocumentReference {
        try subCollection(collectionType: .shoppingList).document(shoppingListItemId)
    }
    
    // Gets all items in shopping list collection for current home
    // Appends to local array and returns this array
    func getShoppingList() async throws -> [ShoppingListItem] {
        var shoppingList:[ShoppingListItem] = []
        let snapshot = try await subCollection(collectionType: .shoppingList).getDocuments()
        for document in snapshot.documents {
            let shoppingListItem = try document.data(as: ShoppingListItem.self)
            shoppingList.append(shoppingListItem)
        }
        return shoppingList
    }
    
    // Adds an item to Firestore shoppingList document
    func addShoppingListItem(shopppingListItem: ShoppingListItem) async throws {
        try shoppingListCollectionDocument(shoppingListItemId: shopppingListItem.id).setData(from: shopppingListItem, merge: false)
    }
    
    // Removes an item from Firestore shoppingList
    func removeShoppingListItem(shoppingListItemId: String) async throws {
        try await shoppingListCollectionDocument(shoppingListItemId: shoppingListItemId).delete()
    }
    
    // Updates an item in Firestore shopping list collection
    func updateShoppingListItem(shoppingListItem: ShoppingListItem) async throws {
        try shoppingListCollectionDocument(shoppingListItemId: shoppingListItem.id).setData(from: shoppingListItem)
    }
}

//MARK: Notices
extension HomeManager {
    
    // Returns notice firestore document
    private func noticeCollectionDocument(noticeId: String) throws -> DocumentReference {
        try subCollection(collectionType: .notices).document(noticeId)
    }
    
    // Gets all items in notices collection for current home
    // Appends to local array and returns this array
    func getNotices() async throws -> [Notice] {
        var notices:[Notice] = []
        let snapshot = try await subCollection(collectionType: .notices).getDocuments()
        for document in snapshot.documents {
            let notice = try document.data(as: Notice.self)
            notices.append(notice)
        }
        return notices
    }
    
    // Adds a notice to Firestore notice sub collection
    func addNotice(notice: Notice) async throws {
        try noticeCollectionDocument(noticeId: notice.id).setData(from: notice, merge: false)
    }
    
    // Removes a notice from Firestore notice sub collection
    func removeNotice(noticeId: String) async throws {
        try await noticeCollectionDocument(noticeId: noticeId).delete()
    }
    
    
}
