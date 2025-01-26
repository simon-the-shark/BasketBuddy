//
//  StorageImage.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 26/01/2025.
//

import SwiftUI

struct StorageImage: View {
    var image: String?
    var category: Product.Category
    var imageDimensionSize: CGFloat?

    @StateObject private var viewModel: ViewModel = .init()
    var body: some View {
        if image == nil || image == "" {
            CategoryIcon(category: category, isEnabled: true)
                .padding(.trailing)
        } else {
            if let loadedImageData = viewModel.loadedImageData {
                if let uiImage = UIImage(data: loadedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(maxWidth: imageDimensionSize, maxHeight: imageDimensionSize == nil ? 200 : imageDimensionSize)
                        .padding(.trailing, imageDimensionSize != nil ? 10 : 0)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: imageDimensionSize, maxHeight: imageDimensionSize == nil ? 200 : imageDimensionSize)
                    .padding(.trailing, imageDimensionSize != nil ? 10 : 0)
                    .onAppear {
                        Task {
                            try await viewModel.loadImage(imagePath: image!)
                        }
                    }
            }
        }
    }
}
