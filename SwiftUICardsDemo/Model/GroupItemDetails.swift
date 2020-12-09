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
        case items
    }
    
    let id: Int
    let items: [ItemDetails]
}
