//
//  CardView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Properties
    
    let model: ItemDetails
    
    // MARK: - View properties

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            
            VStack {
                if let emoji = model.label, emoji.isSingleEmoji {
                    Text(emoji)
                        .font(.system(size: 150))
                }
                Text(model.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 5)
        )
    }
}

// MARK: - Previews

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: ItemDetails(label: "🏵", title: "Слово"))
            .padding()
            .environment(\.sizeCategory, ContentSizeCategory.accessibilityExtraExtraExtraLarge)
    }
}
