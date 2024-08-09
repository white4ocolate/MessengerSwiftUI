//
//  ProfileView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 09.08.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            
            //header
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color(.systemGray4))
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.green)
                    }
                }
                Text("Bruce Wayne")
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
    ProfileView()
}
