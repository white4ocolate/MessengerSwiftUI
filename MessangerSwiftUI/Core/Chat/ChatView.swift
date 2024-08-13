//
//  ChatView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    CircularProfileImageView(user: User.MOCK_USER, size: .xl)
                    VStack(spacing: 4) {
                        Text(User.MOCK_USER.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            HStack (alignment: .bottom) {
                ZStack(alignment: .bottomTrailing) {
                    TextField("Message...", text: $messageText, axis: .vertical)
                        .padding(7)
                        .padding(.trailing, 35)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .font(.subheadline)
                    Button {
                        print("show smile")
                    } label: {
                        Image(systemName: "face.smiling")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(5)
                }
                Button {
                    print("send button tapped")
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .frame(width: 33, height: 33)
                }
            }
            .padding(10)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    ChatView()
}
