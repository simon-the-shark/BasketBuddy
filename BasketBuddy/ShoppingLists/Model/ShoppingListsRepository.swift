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
            let (data, response) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(item.id)/", method: "DELETE", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ])
            return true
        } catch {
            return false
        }
    }

    func editList(with: AuthService, item: ShoppingList) async -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(item)
            let (data, response) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/\(item.id)/", method: "PUT", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ], body: jsonData)
            print("Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            print("Response: \(response)")
            return true
        } catch {
            return false
        }
    }

    func addList(with: AuthService, item: ShoppingListTemplate) async -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(item)
            let (data, response) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/shopping-lists/", method: "POST", headers: [
                "Authorization": "Token \(with.authState.tokenRequired)",
            ], body: jsonData)
            print("Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            print("Response: \(response)")
            return true
        } catch {
            return false
        }
    }
}
