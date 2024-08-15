//
//  InboxRow.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 08.08.2024.
//

import SwiftUI

struct InboxRow: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            CircularProfileImageView(user: User.MOCK_USER, size: .l)
            
            VStack(alignment: .leading) {
                Text("Heath Ledger")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Some text for testing how many line this text give")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: (UIScreen.current?.bounds.width)! - 100, alignment: .leading)
            }
            
            HStack {
                Text("yesterday")
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}

#Preview {
    InboxRow()
}
