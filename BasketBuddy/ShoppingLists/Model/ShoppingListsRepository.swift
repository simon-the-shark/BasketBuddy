import Foundation

class ShoppingListsRepository {
    static let shared = ShoppingListsRepository()
    private init() {}
    private let apiURL = URL(string: "https://basketbuddy.sharkserver.kowalinski.dev/api/v1/shopping-lists/")!
    private let authToken = "303f0402561fd4980987d521493ecead1b65bf08a8adda353146745018fc622b"

    func fetchShoppingLists() async -> [ShoppingList] {
        var request = URLRequest(url: apiURL)
        request.setValue("Token \(authToken)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let shoppingLists = try JSONDecoder().decode([ShoppingList].self, from: data)
            return shoppingLists
        } catch {
            return []
        }
    }
}
