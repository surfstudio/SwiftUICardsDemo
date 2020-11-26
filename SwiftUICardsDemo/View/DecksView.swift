//
//  DecksView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct DecksView: View {
    let decks = DeckMocks.list
    @State var selectedDeck: Deck?

    var body: some View {
        VStack {
            Text("Крокодил")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            ScrollView(showsIndicators: false) {
                Spacer(minLength: 20)
                VStack(spacing: 0) {
                    ForEach(decks) { deck in
                        Button(deck.name) {
                            selectedDeck = deck
                        }
                        .padding()
                        .buttonStyle(DeckButtonStyle())
                    }
                }
                Spacer(minLength: 20)
            }
        }.sheet(item: $selectedDeck) { item in
            DeckView(deck: item)
        }
        .background(Color.darkGreen)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView()
    }
}
