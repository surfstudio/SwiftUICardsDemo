//
//  CardsView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct CardsView: View {
    
    // MARK: - Nested types
    
    fileprivate enum ViewState {
        case loading
        case empty
        case content(cards: [String])
    }
    
    // MARK: - Properties

    @State private var state: ViewState = .loading
    let group: GroupItem
    
    // MARK: - View properties
    
    var body: some View {
        VStack {
            title
            
            switch state {
            case .loading:
                LoadingView()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.accentColor)
                    .onAppear {
                        reload()
                    }
            case .empty:
                Button(action: { state = .loading }) {
                    Label("Повторить", systemImage: "arrow.clockwise")
                }
                .font(.title)
            case let .content(cards):
                content(cards.last!)
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .accentColor(.white)
        .background(BackgroundView(style: .styleTwo))
    }
    
    var title: some View {
        HStack {
            Spacer()
            Text(group.title)
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.vertical)
            Spacer()
        }
    }
    
    // MARK: - Views methods
    
    func content(_ card: String) -> some View {
        CardView(emoji: card, title: nil)
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            .modifier(CardAnimationModifire() {
                state.prepareForNextCard()
            })
    }
    
    // MARK: - Methods
    
    func reload() {
        MockService.main.loadCards(forId: group.id) { cards in
            withAnimation { state.update(forCards: cards) }
        }
    }

}

// MARK: - View state functional

fileprivate extension CardsView.ViewState {
    
    mutating func prepareForNextCard() {
        if case let .content(cards) = self {
            update(forCards: cards.dropLast())
        }
    }
    
    mutating func update(forCards cards: [String]) {
        self = cards.isEmpty ? .empty : .content(cards: cards)
    }
    
}

// MARK: - Loader view

fileprivate struct LoadingView: View {
    @State private var isLoading = false
 
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .strokeBorder(
                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
                    AngularGradient(
                        gradient: Gradient(colors: [.accentColor, .green]),
                        center: .center,
                        startAngle: .zero,
                        endAngle: .degrees(360)
                    ),
                    lineWidth: 5
                )
                .opacity(0.8)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.default.delay(0.01).repeatForever(autoreverses: false))
        }
        .onAppear {
            isLoading = true
        }
    }
}

// MARK: - Card animation modifire

fileprivate struct CardAnimationModifire: ViewModifier {
    
    var showNextCard: (() -> ())?
    
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var angle: Double = 0

    func body(content: Content) -> some View {
        content
            .offset(x: xOffset, y: yOffset)
            .rotationEffect(.init(degrees: angle))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        xOffset = value.translation.width
                        yOffset = value.translation.height
                        angle = getAngle(for: value.translation)
                    }
                    .onEnded { value in
                        if value.translation.width.magnitude > 100 {
                            let sign = value.translation.width.sign == .minus ? -1 : 1
                            xOffset = .init(sign * 700)
                            angle = .init(sign * 15)
                            next()
                        } else {
                            reset()
                        }
                    }
            )
            .animation(.spring())
    }
    
    
    func reset() {
        xOffset = 0
        yOffset = 0
        angle = 0
    }
    
    func next() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            reset()
            showNextCard?()
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

// MARK: - Previews

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView(group: GroupItem(id: 0, label: "", title: "Test"))
            .accentColor(.white)
    }
}