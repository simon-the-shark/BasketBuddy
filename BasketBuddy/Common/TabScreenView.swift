//
//  TabScreenView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct TabScreenView: View {
    enum Tab {
        case home, history, myProducts
    }

    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ShoppingListsListView()
                .tabItem {
                    Label("Listy zakupów", systemImage: "list.clipboard")
                        .background(Color.white.edgesIgnoringSafeArea(.all))
                }
                .tag(Tab.home)

            HistoryView()
                .tabItem {
                    Label("Historia", systemImage: "clock.arrow.2.circlepath")
                }
                .tag(Tab.history)

            MyProductsView()
                .tabItem {
                    Label("Moje produkty", systemImage: "heart.text.clipboard")
                    
                }
                .tag(Tab.myProducts)
        }
        
    }
}

#Preview {
    TabScreenView()
}
