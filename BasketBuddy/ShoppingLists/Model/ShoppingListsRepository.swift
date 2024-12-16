import Foundation

class ShoppingListsRepository {
    static let shared = ShoppingListsRepository()
    private init() {}

    func fetchShoppingLists(with: AuthService) async -> [ShoppingList] {
        guard let token = with.authState.data?.token else {
            return []
        }
        do {
            let (data, _) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/", headers: [
                "Authorization": "Token \(token)",
            ])
            return try JSONDecoder().decode([ShoppingList].self, from: data)

        } catch {
            return []
        }
    }

    func removeList(with: AuthService, item: ShoppingList) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(item.id)/", method: "DELETE", headers: [
                "Authorization": "Token \(token)",
            ])
            return true
        } catch {
            return false
        }
    }

    func editList(with: AuthService, item: ShoppingList) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            let jsonData = try JSONEncoder().encode(item)
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(item.id)/", method: "PUT", headers: [
                "Authorization": "Token \(token)",
            ], body: jsonData)

            return true
        } catch {
            return false
        }
    }

    func addList(with: AuthService, item: ShoppingListTemplate) async -> Bool {
        guard let token = with.authState.data?.token else {
            return false
        }
        do {
            let jsonData = try JSONEncoder().encode(item)
            let _ = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/", method: "POST", headers: [
                "Authorization": "Token \(token)",
            ], body: jsonData)

            return true
        } catch {
            return false
        }
    }
}
