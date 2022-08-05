import SwiftUI

protocol BackpackCategoryItemViewDelegate {
    func backpackCategoryItemViewDidTapButton(from view: BackpackCategoryItemView, withItem item: CategoryItem)
}

struct BackpackCategoryItemView: View {
    var item: CategoryItem
    var delegate: BackpackCategoryItemViewDelegate

    var body: some View {
        VStack {
            Divider()

            Button(action: {
                delegate.backpackCategoryItemViewDidTapButton(from: self, withItem: item)
            }, label: {
                HStack {
                    CategoryItemIcon(iconName: item.icon)

                    Text(item.title)
                        .customFont(.IBMPlexSansSemiBold, size: 16)

                    Spacer()

                    Image("chevron-right")
                        .foregroundColor(.accent)
                        .padding(.trailing, 10)
                }
                .padding(.top, 5)
            })
        }
    }
}
