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
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .foregroundColor(.darkText)

                Spacer()

                Button(action: {
                    categoryViewModel.removeItem(currentItem: item)
                }, label: {
                    Text(AppStrings.ItemView.deleteButton.localized())
                        .modifier(PrimaryTextStyle())
                })
            }

            HStack {
                Text(AppStrings.ItemView.expirationDateLabel.localized())
                    .font(.custom("IBMPlexSans-Regular", size: 14))
                    .foregroundColor(.gray)

                Text(expDate())
                    .font(.custom("IBMPlexSans-Regular", size: 14))
                    .foregroundColor(.gray)

                Spacer()
            }

            Divider()
        }
        .padding(.horizontal)
    }

    func expDate() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MMMM y"
        return formatter4.string(from: item.expirationDate)
    }
}