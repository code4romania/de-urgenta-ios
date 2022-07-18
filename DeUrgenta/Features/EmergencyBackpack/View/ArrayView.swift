import SwiftUI

struct ArrayView: View {
    var itemsArray: [Item]

    var body: some View {
        Divider()
            .padding(.horizontal)
        ForEach(itemsArray, id: \.id) { item in
            // Text("x" + String(item.quantity) + " " + item.name)
            ItemView(item: item)
        }
    }
}
