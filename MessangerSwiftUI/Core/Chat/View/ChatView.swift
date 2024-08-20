//
//  ChatView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    @Environment (\.dismiss) var dismiss
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                     Image(systemName: "lessthan")
                        .resizable()
                        .frame(width: 13, height: 20)
                }
                .frame(width: 40)
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Online")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                CircularProfileImageView(user: user, size: .s)
            }
            .padding(8)
             
            ScrollView {
                ForEach(0...14, id: \.self) {_ in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
            }
            
            HStack (alignment: .bottom) {
                ZStack(alignment: .bottomTrailing) {
                    TextField("Message...", text: $viewModel.messageText, axis: .vertical)
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
                    viewModel.sendMessage()
                    viewModel.messageText = ""
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
    ChatView(user: User.MOCK_USER)
}
