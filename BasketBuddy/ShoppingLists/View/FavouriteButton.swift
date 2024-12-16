//
//  FavouriteButton.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct FavouriteButton: View {
    var body: some View {
        Button {} label: {
            Label("Nie jest ulubiony", systemImage: "star")
                .labelStyle(IconOnlyLabelStyle())
                .font(.system(size: 16))
        }
    }
}

#Preview {
    FavouriteButton()
}
