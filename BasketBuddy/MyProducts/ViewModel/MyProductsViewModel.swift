//
//  MyProductsViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation


//
//  HistoryViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation


extension MyProductsView {
    class ViewModel: ObservableObject {
        
        func logout(with: AuthService) {
            Task {
                try await with.logout()
            }
        }

        
    }
}
