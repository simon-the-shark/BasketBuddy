//
//  ProductsRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

class ProductsRepository {
    static let shared = ProductsRepository()
    private init() {}

    func getAll(with: AuthService) async -> [Product] {
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/products/", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ])
            return try JSONDecoder().decode([Product].self, from: data)

        } catch {
            return []
        }
    }
}
