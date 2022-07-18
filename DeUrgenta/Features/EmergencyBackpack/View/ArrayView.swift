import SwiftUI

struct ArrayView: View {
    var itemsArray: [Item]

    var body: some View {
        Divider()
            .padding(.horizontal)

        ForEach(itemsArray, id: \.id) { item in
            ItemView(item: item)
        }
    }
}
