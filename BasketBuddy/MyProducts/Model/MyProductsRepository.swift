//
//  MyProductsRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import Foundation

class MyProductsRepository {
    private init() {}
    public static let shared = MyProductsRepository()
    private var cachedProducts: [MyProduct] = []

    func getAll(with: AuthService) async -> [MyProduct] {
        if !cachedProducts.isEmpty {
            return cachedProducts
        }
        guard let token = with.authState.data?.token else {
            return []
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/custom-products/", headers: [
                "Authorization": "Token \(token)",
            ])
            print(data)
            let dataParsed = try JSONDecoder().decode([MyProduct].self, from: data)
            cachedProducts = dataParsed
            return dataParsed

        } catch {
            return []
        }
    }

    func addProduct(_ product: CreateMyProductDTO, with: AuthService, imageData: Data?) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            if let filename = product.image, let imageData = imageData {
                let client = try await StorageClient()
                try await client.createFile(bucket: "custom-products", key: filename, withData: imageData)
            }
            let jsonData = try JSONEncoder().encode(product)
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/custom-products/", method: "POST", headers: [
                "Authorization": "Token \(token)",
            ], body: jsonData)
            cachedProducts = []
            return true
        } catch {
            print("Error adding product: \(error)")
            return false
        }
    }

    func updateProduct(_ product: CreateMyProductDTO, productId: Int, with: AuthService, imageData: Data?) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            if let filename = product.image, let imageData = imageData {
                let client = try await StorageClient()
                try await client.createFile(bucket: "custom-products", key: filename, withData: imageData)
            }
            let jsonData = try JSONEncoder().encode(product)
            var jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            if product.image == nil {
                jsonObject["image"] = NSNull()
            }
            let updatedJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let data = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/custom-products/\(productId)/", method: "PUT", headers: [
                "Authorization": "Token \(token)",
            ], body: updatedJsonData)
            print(data)
            cachedProducts = []
            return true
        } catch {
            return false
        }
    }
}
