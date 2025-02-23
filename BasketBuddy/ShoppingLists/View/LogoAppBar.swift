import SwiftUI

struct LogoAppBar<Content: View>: View {
    var content: Content
    var action: () -> Void

    init(@ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void) {
        self.content = content()
        self.action = action

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        let customFont = UIFont(name: "Modak", size: 34) ?? UIFont.systemFont(ofSize: 34)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "RoyalBlue") ?? UIColor.darkGray,
            .font: customFont,
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        content
            .navigationTitle("BasketBuddy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 70.0, height: 66.0)
                        .ignoresSafeArea()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: action) {
                        Label("Dodaj listę", systemImage: "plus.app")
                    }.controlSize(.extraLarge).padding(.top, 20)
                }
            }.padding(.top, 20)
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
