//
//  MyProductFormData.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import Foundation

struct MyProductFormData: Codable {
    let category: Product.Category
    let image: String?
    let name: String?
}

extension MyProductFormData {
    init(from product: MyProduct) {
        category = product.category
        image = product.image
        name = product.name
    }
}
