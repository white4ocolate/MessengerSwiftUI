//
//  ChatMessageCell.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool
    var body: some View {
        HStack {
            if isFromCurrentUser {
                
                Spacer()
                
                Text("This is the test message for now longer text where we see how it's now and maybe later. Because people love typing big text in one message. If this background lokks like circle we should change it on rectangle")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(MessageBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: ((UIScreen.current?.bounds.width)!) / 1.2, alignment: .trailing)
            } else {
                Text("This is the test message for now longer text where we see how it's now and maybe later. Because people love typing big text in one message. If this background lokks like circle we should change it on rectangle ")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .foregroundStyle(.black)
                    .clipShape(MessageBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: ((UIScreen.current?.bounds.width)!) / 1.2, alignment: .leading)
                
                Spacer()
                
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: true)
}
