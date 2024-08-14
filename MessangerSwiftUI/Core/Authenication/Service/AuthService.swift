//
//  AuthService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static private let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print(">>>DEBUG: user session id is \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print(">>>DEBUG: Login user \(result.user.uid)")
            self.userSession = result.user
        } catch {
            print(">>>DEBUG: Cant login user beacuse \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print(">>>DEBUG: Create user \(result.user.uid)")
            self.userSession = result.user
            
        } catch {
            print(">>>DEBUG: Cant create user beacuse \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(">>>DEBUG: Cant logout user beacuse \(error.localizedDescription)")
        }
    }
}
