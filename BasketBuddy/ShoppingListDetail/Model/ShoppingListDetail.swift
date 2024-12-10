//
//  ShoppingListDetail.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

enum Unit: String, CaseIterable, Codable {
    case pieces = "PIECES"
    case kilogram = "KILOGRAM"
    case gram = "GRAM"
    case liters = "LITERS"
    case meters = "METERS"

    var polishTranslation: String {
        switch self {
        case .pieces: return "Sztuki"
        case .kilogram: return "Kilogram"
        case .gram: return "Gram"
        case .liters: return "Litry"
        case .meters: return "Metry"
        }
    }
}

struct ShoppingListItemTemplate: Codable {
    let product_id: Int
    let quantity: Int
    let unit: Unit
    let isBought: Bool
}

struct ShoppingListItem: Codable, Identifiable {
    let id: Int
    let product: Product
    var quantity: Int
    let unit: Unit
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
