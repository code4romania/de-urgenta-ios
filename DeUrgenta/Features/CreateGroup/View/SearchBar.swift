import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        VStack {
            HStack {
                TextField(AppStrings.SearchBar.textFieldPlaceholder.localized(), text: $text)
                    .foregroundColor(.gray)
                    .padding(.top, 9)
                    .padding(.bottom, 9)
                    .padding(.leading, 13)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 11)

                })
        }
        .background(Color.white)
        .padding(.vertical)
    }
}
