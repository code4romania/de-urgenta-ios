import SwiftUI

struct ItemView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel
    var item: Item

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(String(item.quantity) + " x")
                    .foregroundColor(.gray)

                Text(item.name)
                    .customFont(.IBMPlexSansSemiBold, size: 20)

                Spacer()

                Button(action: {
                    categoryViewModel.removeItem(currentItem: item)
                }, label: {
                    Text(AppStrings.ItemView.deleteButton.localized())
                        .customFont(size: 16)
                })
            }

            HStack {
                Text(AppStrings.ItemView.expirationDateLabel.localized())
                    .foregroundColor(.gray)
                    .customFont(size: 14)

                Text(categoryViewModel.getExpirationDate(date: item.expirationDate))
                    .foregroundColor(.gray)
                    .customFont(size: 14)

                Spacer()
            }

            Divider()
        }
        .padding(.horizontal)
    }
}
