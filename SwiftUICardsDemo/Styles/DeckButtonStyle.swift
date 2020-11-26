//
//  DeckButtonStyle.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct DeckButtonStyle: ButtonStyle {
    private let bgColor = Color.white

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.darkGreen)
            .font(.title2)
            .frame(maxWidth: .infinity, minHeight: 70)
            .background(bgColor.opacity(configuration.isPressed ? 0.8 : 1))
            .contentShape(Rectangle())
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring())
    }
}

struct DeckButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button", action: { })
            .buttonStyle(DeckButtonStyle())
            .padding(50)
            .background(Color.gray)
    }
}

extension Color {
    static let darkGreen = Color(red: 0.04, green: 0.196, blue: 0.125)
}
