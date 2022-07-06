import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        VStack {
            HStack {
                TextField(AppStrings.SearchBar.textFieldPlaceholder.localized(), text: $text)
                    .foregroundColor(.darkText)
                    .padding(.vertical, 9)
                    .padding(.leading, 13)
            }.overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 11)

                })
        }
        .background(Color.white)
        .cornerRadius(6)
        .padding(.vertical)
    }
}
