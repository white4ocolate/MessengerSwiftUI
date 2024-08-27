//
//  ImageService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 27.08.2024.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth

class ImageService {
    
    static let shared = ImageService()
    
    func uploadImage(_ imageData: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = Storage.storage().reference()
        let user = Auth.auth().currentUser
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let avatarRef = storageRef.child("avatars").child(currentUid)
        
        avatarRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            avatarRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    Firestore.firestore().collection("users").document(currentUid).setData(["profileImageUrl": url.absoluteString], merge: true)
                    completion(.success(url))
                }
            }
        }
    }
}
