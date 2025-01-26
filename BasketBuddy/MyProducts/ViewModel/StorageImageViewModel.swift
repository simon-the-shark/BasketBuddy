//
//  StorageImageViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 26/01/2025.
//

import Foundation

extension StorageImage {
    class ViewModel: ObservableObject {
        @Published var loadedImageData: Data?

        func loadImage(imagePath: String) async throws {
            let client = try await StorageClient()
            let data = try await client.readFile(bucket: "custom-products", key: imagePath)
            DispatchQueue.main.async {
                self.loadedImageData = data
            }
        }
    }
}
