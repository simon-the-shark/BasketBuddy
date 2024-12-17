//
//  FavViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import CoreData
import Foundation

extension FavouriteButton {
    class ViewModel: ObservableObject {
        private var repository = FavRepository.shared

        func addToFavs(with: NSManagedObjectContext, id: Int) {
            repository.appendObject(context: with, itemId: id)
        }

        func removeFromFavs(with: NSManagedObjectContext, id: Int) {
            repository.deleteObject(context: with, itemId: id)
        }
    }
}
