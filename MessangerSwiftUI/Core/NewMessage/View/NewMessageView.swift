//
//  NewMessageView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 09.08.2024.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @StateObject var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(viewModel.users ?? []) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .s)
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 20)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
