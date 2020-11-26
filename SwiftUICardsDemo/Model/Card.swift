//
//  Card.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct Card: Identifiable {
    let id: String
    let title: String
    let color: Color

    init(title: String, color: Color) {
        self.id = UUID().uuidString
        self.title = title
        self.color = color
    }
}
