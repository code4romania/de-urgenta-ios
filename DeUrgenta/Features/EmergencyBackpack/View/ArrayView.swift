import SwiftUI

struct ArrayView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        Divider()
            .padding(.horizontal)

        ForEach(categoryViewModel.currentItemsArray.indices, id: \.self) { index in
            ItemView(categoryViewModel: categoryViewModel, item: categoryViewModel.currentItemsArray[index])
        }
    }
}
