//
//  ShoppingList.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 07/12/2024.
//

import Foundation

struct ShoppingListTemplate: Codable {
    let name: String
    let color: String
    let emoji: String
    let isActive: Bool
}

struct ShoppingList: Codable, Identifiable {
    let id: Int
    var name: String
    let color: String
    let emoji: String
    let isActive: Bool
    let owner: Int
}
