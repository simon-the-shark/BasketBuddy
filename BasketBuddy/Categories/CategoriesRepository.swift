//
//  CategoriesRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import Foundation


class CategoriesRepository {
    private init (){}
    public static let shared = CategoriesRepository()
    private var cached: [Product.Category] = []

    func getAll(with: AuthService) async -> [Product.Category] {
        if (!cached.isEmpty){
            return cached
        }
        guard let token = with.authState.data?.token else {
            return []
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/product-categories/", headers: [
                "Authorization": "Token \(token)",
            ])
            print(data);
            let dataParsed = try JSONDecoder().decode([Product.Category].self, from: data)
            cached = dataParsed
            return dataParsed

        } catch {
            return []
        }
    }
}
