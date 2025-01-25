//
//  MyProductsDetailView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import SwiftUI
import PhotosUI

struct MyProductsFormView: View {
    @ObservedObject var viewModel: ViewModel

    init(product: MyProduct, categories: [Product.Category]) {
        self.viewModel = ViewModel(categories: categories, initialData: product)
    }
    
    init(categories: [Product.Category]) {
        self.viewModel = ViewModel(categories: categories, initialData: nil)
    }
    
    
    var body: some View {
        List {
            Section(header: Text("Dane Produktu")) {
                HStack {
                    Text("Nazwa")
                    TextField("Nazwa", text: $viewModel.productName)
                }
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
                if(viewModel.imagePreviewData == nil){
                    Image(uiImage: #imageLiteral(resourceName: "\(viewModel.selectedCategory.id)_product_category.png")).resizable().frame(maxWidth: .infinity, maxHeight: 200)
                }
                if (viewModel.imagePreviewData != nil){
                    if let uiImage = UIImage(data: viewModel.imagePreviewData!) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .padding(0)
                    }
                }
                HStack {
                    Text("Możesz tez wybrać obraz")
                    Spacer()
                    if(viewModel.haveCustomImage){
                        PhotosPicker("Zmień", selection:  $viewModel.imageItem, matching: .images)
                    }
                }
            }
            
            HStack {
                Spacer()
                Button {
                   
                } label: {
                    Text("Zapisz")
                }
                Spacer()
            }
        }
        .navigationBarTitle("Dodaj swój product")
    }
}

