import Foundation

class ShoppingListsRepository {
    static let shared = ShoppingListsRepository()
    private init() {}

    func fetchShoppingLists(with: AuthService) async -> [ShoppingList] {
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ])
            return try JSONDecoder().decode([ShoppingList].self, from: data)

        } catch {
            return []
        }
    }

    func removeList(with: AuthService, item: ShoppingList) async -> Bool {
        do {
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(item.id)", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ])
            return true

        } catch {
            return false
        }
    }
}
