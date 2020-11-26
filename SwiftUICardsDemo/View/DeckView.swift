//
//  DeckView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct DeckView: View {

    @State var deck: Deck

    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var angle: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(deck.name)
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .font(.title)
                    .padding()
                Spacer()
            }
            ZStack {
                Color.darkGreen
                if let card = deck.cards.last {
                    CardView(title: card.title, color: card.color)
                        .padding(.vertical, 50)
                        .padding(.horizontal, 20)
                        .offset(x: xOffset, y: yOffset)
                        .rotationEffect(.init(degrees: angle))
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        xOffset = value.translation.width
                                        yOffset = value.translation.height
                                        angle = getAngle(for: value.translation)
                                    }
                                    .onEnded { value in
                                        if value.translation.width > 0 {
                                            if value.translation.width > 100 {
                                                xOffset = 700
                                                angle = 15
                                                next()
                                            } else {
                                                reset()
                                            }
                                        } else {
                                            if value.translation.width < -100 {
                                                xOffset = -700
                                                angle = -15
                                                next()
                                            } else {
                                                reset()
                                            }
                                        }
                                    }
                            )
                } else {
                    Text("Это были все карточки")
                }
            }
        }
        .background(Color.darkGreen)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.spring())
    }

    func reset() {
        xOffset = 0
        yOffset = 0
        angle = 0
    }

    func next() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            deck.cards.removeLast()
            reset()
        }
    }

    func getAngle(for translation: CGSize) -> Double {
        let x = translation.width
        let y = translation.height
        switch (x > 0, y > 0) {
        case (true, true), (false, false):
            return -8
        case (true, false), (false, true):
            return 8
        }
    }

}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(deck: DeckMocks.first)
            .background(Color.gray)
    }
}
