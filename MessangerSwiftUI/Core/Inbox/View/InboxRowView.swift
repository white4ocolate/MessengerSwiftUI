//
//  InboxRow.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 08.08.2024.
//

import SwiftUI

struct InboxRowView: View {
    let message: Message
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            CircularProfileImageView(user: message.user, size: .l)
            
            VStack(alignment: .leading) {
                Text(message.user!.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(message.messageText)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: (UIScreen.current?.bounds.width)! - 100, alignment: .leading)
            }
            
            HStack {
                Text(message.timestampString)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}
