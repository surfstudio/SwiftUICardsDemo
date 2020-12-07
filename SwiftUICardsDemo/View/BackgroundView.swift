//
//  BackgroundView.swift
//  SwiftUICardsDemo
//
//  Created by Erik Basargin on 05/12/2020.
//

import SwiftUI

struct BackgroundView: View {
    
    enum Style {
        case styleOne
        case styleTwo
    }
    
    let style: Style
    
    var body: some View {
        VStack {
            Spacer()
            style.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.5)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.sRGB, red: 54 / 255, green: 170 / 255, blue: 47 / 255, opacity: 1),
                    Color(.sRGB, red: 48 / 255, green: 154 / 255, blue: 41 / 255, opacity: 1),
                    Color(.sRGB, red: 45 / 255, green: 143 / 255, blue: 40 / 255, opacity: 1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}

fileprivate extension BackgroundView.Style {
    
    var image: Image {
        switch self {
        case .styleOne:
            return Image("background")
        case .styleTwo:
            return Image("backgroundTwo")
        }
    }
}
