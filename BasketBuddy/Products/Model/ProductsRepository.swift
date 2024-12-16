import Foundation

class ProductsRepository {
    static let shared = ProductsRepository()
    private init() {}

    private var cachedProducts: [Product] = []

    func getAll(with: AuthService) async -> [Product] {
        if !cachedProducts.isEmpty {
            return cachedProducts
        }
        guard let token = with.authState.data?.token else {
            return []
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/products/", headers: [
                "Authorization": "Token \(token)",
            ])
            let products = try JSONDecoder().decode([Product].self, from: data)
            cachedProducts = products
            return products

        } catch {
            return []
        }
    }

    func clearCache() {
        cachedProducts.removeAll()
    }
}
