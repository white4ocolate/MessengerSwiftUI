//
//  ChatMessageCell.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser  {
                
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(MessageBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: ((UIScreen.current?.bounds.width)!) / 1.2, alignment: .trailing)
            } else {
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray4))
                    .foregroundStyle(Color("foregroundColor"))
                    .clipShape(MessageBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: ((UIScreen.current?.bounds.width)!) / 1.2, alignment: .leading)
                
                Spacer()
                
            }
        }
        .padding(.horizontal, 8)
    }
}
