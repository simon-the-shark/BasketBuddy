//
//  MyProductsFormView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import PhotosUI
import SwiftUI

struct MyProductsFormView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject private var authService: AuthService
    @Environment(\.dismiss) var dismiss

    init(product: MyProduct, categories: [Product.Category], onDisappear: @escaping () -> Void = {}) {
        viewModel = ViewModel(categories: categories, initialData: product)
        self.onDisappear = onDisappear
    }

    init(categories: [Product.Category], onDisappear: @escaping () -> Void = {}) {
        viewModel = ViewModel(categories: categories, initialData: nil)
        self.onDisappear = onDisappear
    }

    private var onDisappear: () -> Void

    var body: some View {
        ZStack {
            List {
                Section(header: Text("Dane Produktu")) {
                    NameInput(viewModel: viewModel)
                    Picker("Kategoria", selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category.name).tag(category)
                        }
                    }
                    Toggle(isOn: $viewModel.haveCustomImage) {
                        Text("Wybierz swój obraz")
                    }
                }
                Section(header: Text("Obraz/Ikona")) {
                    if viewModel.imagePreviewData == nil {
                        StorageImage(image: viewModel.product.image, category: viewModel.selectedCategory)
                    }
                    if viewModel.imagePreviewData != nil {
                        if let uiImage = UIImage(data: viewModel.imagePreviewData!) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .padding(0)
                        }
                    }
                    HStack {
                        Text("Możesz tez wybrać obraz")
                        Spacer()
                        if viewModel.haveCustomImage {
                            PhotosPicker("Zmień", selection: $viewModel.imageItem, matching: .images)
                        }
                    }
                }

                HStack {
                    Spacer()
                    Button {
                        Task {
                            await viewModel.saveProduct(with: authService)
                            dismiss()
                        }

                    } label: {
                        Text("Zapisz")
                    }
                    Spacer()
                }
            }

            .navigationBarTitle("Dodaj swój product")
            .onDisappear {
                onDisappear()
            }

            if viewModel.isLoading {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                ProgressView("Loading ...")
                    .foregroundColor(.black)
            }
        }
    }
}
