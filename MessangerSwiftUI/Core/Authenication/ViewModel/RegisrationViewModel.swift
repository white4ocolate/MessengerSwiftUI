//
//  RegisrationViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

class RegisrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
