//
//  ShoppingListDetail.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

struct ShoppingListItemTemplate: Codable {
    let product_id: Int
    let quantity: Int
    let unit: String
    let isBought: Bool
}

struct ShoppingListItem: Codable, Identifiable {
    let id: Int
    let product: Product
    let quantity: Int
    let unit: String
    let isBought: Bool
}

struct ShoppingListDetail: Codable, Identifiable {
    let id: Int
    var items: [ShoppingListItem]
    var name: String
    let color: String
    let emoji: String
    let isActive: Bool
    let owner: Int
}
