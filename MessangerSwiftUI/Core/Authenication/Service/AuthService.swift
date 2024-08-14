//
//  AuthService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func login(withEmail email: String, password: String) async throws {
        print(">>>DEBUG: email is \(email)")
        print(">>>DEBUG: password is \(password)")
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print(">>>DEBUG: Create user \(result.user.uid)")
        } catch {
            
        }
    }
}
