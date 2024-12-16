//
//  ShoppingListDetailRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

class ShoppingListDetailRepository {
    static let shared = ShoppingListDetailRepository()
    private init() {}

    func getById(id: Int, with: AuthService) async -> ShoppingListDetail? {
        guard let token = with.authState.data?.token else {
            return nil
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(id)/", headers: [
                "Authorization": "Token \(token)",
            ])
            return try JSONDecoder().decode(ShoppingListDetail.self, from: data)

        } catch {
            return nil
        }
    }

    func addProduct(with: AuthService, listId: Int, product: Product) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            let item = ShoppingListItemTemplate(product_id: product.id, quantity: 1, unit: Unit.pieces, isBought: false)
            let jsonData = try JSONEncoder().encode(item)
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(listId)/items/", method: "POST", headers: [
                "Authorization": "Token \(token)",
            ], body: jsonData)

            return true
        } catch {
            return false
        }
    }

    func updateItem(with: AuthService, listId: Int, itemId: Int, newItem: ShoppingListItemTemplate) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            let jsonData = try JSONEncoder().encode(newItem)
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(listId)/items/\(itemId)/", method: "PUT", headers: [
                "Authorization": "Token \(token)",
            ], body: jsonData)
            return true
        } catch {
            return false
        }
    }
}
