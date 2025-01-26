//
//  CreateMyProductDTO.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import Foundation

struct CreateMyProductDTO: Codable, Hashable {
    let category_id: Int
    let image: String?
    let name: String
}
