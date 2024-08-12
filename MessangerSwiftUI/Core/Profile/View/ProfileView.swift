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
            //header
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
                            Image(user.profileImageUrl ?? "")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
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
            
            //list
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageBackgroundColor)
                            Text(option.title)
                                .font(.subheadline)
                        }
                        
                    }
                    
                }
                
                Section {
                    Button("Log Out") {
                        print("Log out")
                    }
                    Button("Delete Account") {
                        print("Delete Account")
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
