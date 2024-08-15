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
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                List {
                    ForEach( 0 ... 10, id: \.self) { message in
                        NavigationLink {
                            ChatView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            InboxRow()
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: (UIScreen.current?.bounds.height)! - 120)
                
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            //when showNewMessageView changes to true this func will trigger and show us the new message view
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        NavigationLink(value: user) {
                            CircularProfileImageView(user: user, size: .xs)
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
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
