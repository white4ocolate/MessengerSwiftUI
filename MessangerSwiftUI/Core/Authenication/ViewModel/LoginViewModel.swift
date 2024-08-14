//
//  LoginViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
