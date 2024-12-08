//
//  ShoppingList.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 07/12/2024.
//

import Foundation

struct ShoppingList: Codable, Identifiable {
    struct Item: Codable, Identifiable {
        struct Product: Codable, Identifiable {
            struct Category: Codable, Identifiable {
                let id: Int
                let name: String
            }

            let id: Int
            let category: Category
            let name: String
        }

        let id: Int
        let product: Product
        let quantity: Int
        let unit: String
        let isBought: Bool
    }

    let id: Int
    let items: [Item]
    var name: String
    let color: String
    let emoji: String
    let isActive: Bool
    let owner: Int
}

extension ShoppingList {
    static var example: ShoppingList {
        return ShoppingList(
            id: 1,
            items: [
                Item(
                    id: 1,
                    product: Item.Product(
                        id: 1,
                        category: Item.Product.Category(id: 1, name: "Fruits"),
                        name: "Apple"
                    ),
                    quantity: 5,
                    unit: "pcs",
                    isBought: false
                ),
                Item(
                    id: 2,
                    product: Item.Product(
                        id: 2,
                        category: Item.Product.Category(id: 2, name: "Vegetables"),
                        name: "Carrot"
                    ),
                    quantity: 10,
                    unit: "pcs",
                    isBought: true
                ),
            ],
            name: "Weekly Groceries",
            color: "Red",
            emoji: "🛒",
            isActive: true,
            owner: 1
        )
    }
}
