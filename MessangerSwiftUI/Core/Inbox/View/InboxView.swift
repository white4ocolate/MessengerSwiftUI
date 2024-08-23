//
//  InboxView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 08.08.2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                ForEach(viewModel.lastmessages) { message in
                    //for hide standard chevron
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        InboxRowView(message: message)
                    }
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                        .navigationBarBackButtonHidden()
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .chatView(let user):
                    ChatView(user: user)
                        .navigationBarBackButtonHidden()
                case .profile(let user):
                    ProfileView(user: user)
                }
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                        .navigationBarBackButtonHidden()
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircularProfileImageView(user: user, size: .xs)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
