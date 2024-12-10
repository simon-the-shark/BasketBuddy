//
//  Product.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

struct Product: Codable, Identifiable {
    struct Category: Codable, Identifiable, Hashable {
        let id: Int
        let name: String
    }

    let id: Int
    let category: Category
    let name: String
}
