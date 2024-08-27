//
//  ProfileView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 09.08.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    let user: User
    
    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    ZStack(alignment: .bottomTrailing) {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            CircularProfileImageView(user: user, size: .xl)
                        }
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.green)
                        }
                    }
                }
                Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            List {
                Section {
                    ThemeView()
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageBackgroundColor)
                            Text(option.title)
                                .font(.subheadline)
                                .foregroundStyle(Color(.systemGray2))
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        try? AuthService.shared.signOut()
                    }
                    Button("Delete Account") {
                        AuthService.shared.deleteAccount()
                    }
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
