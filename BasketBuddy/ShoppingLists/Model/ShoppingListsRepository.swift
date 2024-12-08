import Foundation

class ShoppingListsRepository {
    static let shared = ShoppingListsRepository()
    private init(){}
    private let apiURL = URL(string: "https://basketbuddy.sharkserver.kowalinski.dev/api/v1/shopping-lists/")!
    private let authToken = "" 
    
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
