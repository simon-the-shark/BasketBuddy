//
//  BasketBuddyApp.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 06/12/2024.
//

import SwiftUI

@main
struct BasketBuddyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AuthService())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
