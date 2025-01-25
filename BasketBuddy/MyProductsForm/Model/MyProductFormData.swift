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
        self.category = product.category
        self.image = product.image
        self.name = product.name
    }
}
