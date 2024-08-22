//
//  Constants.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 21.08.2024.
//

import Foundation
import Firebase
import FirebaseAuth

struct FirestoreConstants {
    static let USERS_COLLECTION = Firestore.firestore().collection("users")
    static let MESSAGES_COLLECTION = Firestore.firestore().collection("messages")
}
