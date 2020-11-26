//
//  CardView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct CardView: View {
    let title: String
    let color: Color

    var body: some View {
        ZStack {
            color
            Text(title)
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 10)
        )

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Слово", color: .orange)
            .padding()
    }
}
