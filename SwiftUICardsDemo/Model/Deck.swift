//
//  Deck.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import Foundation

struct Deck: Identifiable {
    let id: String
    let name: String
    var cards: [Card]

    init(name: String, cards: [Card]) {
        self.id = UUID().uuidString
        self.name = name
        self.cards = cards
    }
}

enum DeckMocks {

    static var first: Deck {
        Deck(name: "Животные", cards: [
            .init(title: "Лягушка", color: .green),
            .init(title: "Орёл", color: .blue),
            .init(title: "Тигр", color: .orange),
            .init(title: "Цыпленок", color: .yellow),
            .init(title: "Кот", color: .gray),
            .init(title: "Хамелеон", color: .purple)
        ].shuffled())
    }

    static var second: Deck {
        Deck(name: "Еда", cards: [
            .init(title: "Яблоко", color: .green),
            .init(title: "Голубика", color: .blue),
            .init(title: "Апельсин", color: .orange),
            .init(title: "Банан", color: .yellow),
            .init(title: "Сахар", color: .gray),
            .init(title: "Торт", color: .purple)
        ].shuffled())
    }

    static var third: Deck {
        Deck(name: "Спорт", cards: [
            .init(title: "Футбол", color: .green),
            .init(title: "Хоккей", color: .blue),
            .init(title: "Баскетбол", color: .orange),
            .init(title: "Теннис", color: .yellow),
            .init(title: "Волейбол", color: .gray),
            .init(title: "Шахматы", color: .purple)
        ].shuffled())
    }

    static var list: [Deck] {
        return [first, second, third, first, second, third, first, second, third, first, second, third, first, second, third]
    }

}
