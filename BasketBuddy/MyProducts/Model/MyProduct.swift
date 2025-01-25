//
//  MyProduct.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import Foundation

struct MyProduct: Codable, Identifiable, Hashable {
    let id: Int
    let category: Product.Category
    let image: String?
    let name: String
    let owner: Int
}
