//
//  MyProductsRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import Foundation


class MyProductsRepository {
    private init (){}
    public static let shared = MyProductsRepository()
    private var cachedProducts: [MyProduct] = []

    func getAll(with: AuthService) async -> [MyProduct] {
        if (!cachedProducts.isEmpty){
            return cachedProducts
        }
        guard let token = with.authState.data?.token else {
            return []
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/custom-products/", headers: [
                "Authorization": "Token \(token)",
            ])
            print(data);
            let dataParsed = try JSONDecoder().decode([MyProduct].self, from: data)
            cachedProducts = dataParsed
            return dataParsed

        } catch {
            return []
        }
    }
}
