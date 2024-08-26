//
//  ModeView.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 26.08.2024.
//

import SwiftUI

struct ModeView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some View {
        Button(action: {
            print(">>>DEBUG: isDarkMode = \(isDarkMode)")
            isDarkMode.toggle()
        }, label: {
            HStack{
                if (isDarkMode) {
                    Image(systemName: "lightbulb.max.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(.white))
                    Text("Light mode")
                        .font(.subheadline)
                } else {
                    Image(systemName: "moon.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(.black))
                    Text("Dark mode")
                        .font(.subheadline)
                }
            }
        })
        .buttonStyle(.plain)
    }
}

#Preview {
    ModeView()
}
