//
//  NoListsInfo.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import SwiftUI

struct NoListsInfo: View {
    var body: some View {
        Section {
            Label("", systemImage: "list.dash")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .padding(.top)
            Text("Brak list z zakupami")
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
                .background(Color.clear)
        }
    }
}
