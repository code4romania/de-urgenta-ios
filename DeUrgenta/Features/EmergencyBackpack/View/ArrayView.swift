import SwiftUI

struct ArrayView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        Divider()
            .padding(.horizontal)

        ForEach(categoryViewModel.currentItemsArray.indices, id: \.self) { index in
            let currentItem = categoryViewModel.currentItemsArray[index]
            ItemView(categoryViewModel: categoryViewModel, item: currentItem)
        }
    }
}
