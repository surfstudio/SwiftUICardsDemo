//
//  GroupItemDetails.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct GroupItemDetails: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id = "groupId"
        case words = "items"
    }
    
    let id: Int
    let words: [String]
}
