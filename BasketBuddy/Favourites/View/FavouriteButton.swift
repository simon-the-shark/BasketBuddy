//
//  FavouriteButton.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import CoreData
import SwiftUI

struct FavouriteButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ViewModel = .init()

    var isFavourite: Bool
    var itemId: Int

    var body: some View {
        if !isFavourite {
            Button {
                viewModel.addToFavs(with: viewContext, id: itemId)
            } label: {
                Label("Nie jest ulubiony", systemImage: "star")
                    .labelStyle(IconOnlyLabelStyle())
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
            }
        } else {
            Button {
                viewModel.removeFromFavs(with: viewContext, id: itemId)
            } label: {
                Label("Jest ulubiony", systemImage: "star.fill")
                    .labelStyle(IconOnlyLabelStyle())
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
            }
        }
    }
}
