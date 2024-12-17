//
//  FavRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//
import CoreData

class FavRepository {
    private init() {}
    static let shared = FavRepository()

    func appendObject(context: NSManagedObjectContext, itemId: Int) {
        let newItem = FavouriteShoppingList(context: context)
        newItem.id = Int64(itemId)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func deleteObject(context: NSManagedObjectContext, itemId: Int) {
        let fetchRequest: NSFetchRequest<FavouriteShoppingList> = FavouriteShoppingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==\(Int64(itemId))")
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
