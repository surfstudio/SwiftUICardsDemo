//
//  MockService.swift
//  SwiftUICardsDemo
//
//  Created by Erik Basargin on 06/12/2020.
//

import Foundation

final class MockService {
    
    static let main: MockService = .init()
    
    var groups: [GroupItem] {
        guard let url = Bundle.main.url(forResource: "groups", withExtension: "json"),
              let data = try? Data(contentsOf: url, options: .mappedIfSafe),
              let groups = try? JSONDecoder().decode([GroupItem].self, from: data) else {
            fatalError()
        }
        return groups
    }
    
    func loadCards(forId id: Int, complitionHandler: @escaping ([String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let url = Bundle.main.url(forResource: "groupItems", withExtension: "json"),
                  let data = try? Data(contentsOf: url, options: .mappedIfSafe),
                  let groups = try? JSONDecoder().decode([GroupItemDetails].self, from: data) else {
                fatalError()
            }
            complitionHandler(groups.first { $0.id == id }?.words ?? [])
        }
    }
}
