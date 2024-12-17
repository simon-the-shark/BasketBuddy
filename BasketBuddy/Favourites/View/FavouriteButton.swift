//
//  FavouriteButton.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import CoreData
import SwiftUI

struct FavouriteButtonLabel: View {
    var text: String
    var systemImage: String
    var onTap: () -> Void

    var body: some View {
        Label(text, systemImage: systemImage)
            .labelStyle(IconOnlyLabelStyle())
            .font(.system(size: 16))
            .foregroundColor(.accentColor)
            .simultaneousGesture(TapGesture().onEnded {
                onTap()
            })
    }
}

struct FavouriteButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ViewModel = .init()

    var isFavourite: Bool
    var itemId: Int

    var body: some View {
        if !isFavourite {
            FavouriteButtonLabel(text: "Nie jest ulubiony", systemImage: "star") {
                withAnimation {
                    viewModel.addToFavs(with: viewContext, id: itemId)
                }
            }
        } else {
            FavouriteButtonLabel(text: "Jest ulubiony", systemImage: "star.fill") {
                withAnimation {
                    viewModel.removeFromFavs(with: viewContext, id: itemId)
                }
            }
        }
    }
}
