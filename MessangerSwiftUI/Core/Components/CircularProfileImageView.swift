//
//  CircularProfileImageView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 12.08.2024.
//

import SwiftUI

enum ProfileImageSize {
    case xxs
    case xs
    case s
    case m
    case l
    case xl
    
    var dimension: CGFloat {
        switch self {
        case .xxs: return 28
        case .xs : return 32
        case .s  : return 40
        case .m  : return 56
        case .l  : return 64
        case .xl : return 80
        }
    }
}

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER, size: .xl)
}
