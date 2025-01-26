//
//  MyProductsDetailViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import PhotosUI
import Foundation
import SwiftUI

extension MyProductsFormView {
    class ViewModel: ObservableObject {
        private let myProductsRepository = MyProductsRepository.shared
        
        @Published var product: MyProductFormData

        @Published var productName: String {
            didSet {
                product = MyProductFormData(category: product.category, image: product.image, name: productName)
            }
        }
        
        @Published var selectedCategory: Product.Category {
            didSet {
                product = MyProductFormData(category: selectedCategory, image: product.image, name: product.name)
            }
        }
        
        @Published var haveCustomImage: Bool {
            didSet {
                product = MyProductFormData( category: product.category, image: nil, name: product.name)
                imagePreviewData = nil
                imageItem = nil
            }
        }
        
        @Published var imagePreviewData: Data?
        
        @Published var imageItem: PhotosPickerItem? {
            didSet {
                
                if let imageItem = imageItem {
                    imageItem.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let imageData):
                            if let imageData = imageData {
                                DispatchQueue.main.async {
                                    self.imagePreviewData = imageData
                                }
                            }
                        case .failure(let error):
                            print("Error loading image data: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
        
        @Published var categories: [Product.Category]
        
        let initialData: MyProduct?
        
        init(categories: [Product.Category], initialData: MyProduct?) {
            self.initialData = initialData
            self.categories = categories
            let category = categories.first ?? Product.Category(id: 0, name: "")
            let product = initialData == nil ? MyProductFormData(category: category, image: nil, name: nil) : MyProductFormData(from: initialData!)
            self.product = product
            self.productName = product.name ?? ""
            self.selectedCategory = product.category
            self.haveCustomImage = product.image != nil
        }
        
        func saveProduct(with: AuthService) async {
            let filename = "custom-products/user_\(with.authState.data!.userId)/product_\(UUID().uuidString)"
            let newProduct = CreateMyProductDTO(category_id: selectedCategory.id, image: filename, name: product.name ?? "super nazwa")
            if let updatingProduct = initialData {
                let _ = await myProductsRepository.updateProduct(newProduct, productId: updatingProduct.id, with: with, imageData: self.imagePreviewData)
            } else {
                let _ = await myProductsRepository.addProduct(newProduct, with: with, imageData: self.imagePreviewData)
            }
        }
    }
}
