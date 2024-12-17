//
//  LoadingOverlay.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import SwiftUI

struct LoadingOverlay<Content: View>: View {
    var isLoading: Bool
    var content: Content
    init(isLoading: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isLoading = isLoading
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
            if isLoading {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                ProgressView("Loading ...")
                    .foregroundColor(.black)
            }
        }
        .animation(.easeInOut, value: isLoading)
    }
}

#Preview {
    LoadingOverlay(isLoading: true) {
        List {
            Text("loaded")
            Text("loaded2")
        }
    }
}
