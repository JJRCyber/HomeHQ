//
//  HomeManager.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 31/8/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeProfile {
    let name: String
    let address: String
    let members: [String]
}
