import SwiftUI

protocol BackpackItemViewDelegate {
    func backpackItemViewDidTapButton(from view: BackpackItemView, withItem item: CategoryItem)
}

struct BackpackItemView: View {
    var item: CategoryItem
    var delegate: BackpackItemViewDelegate

    var body: some View {
        VStack {
            Divider()

            Button(action: {
                delegate.backpackItemViewDidTapButton(from: self, withItem: item)
            }, label: {
                HStack {
                    ItemIcon(iconName: item.icon)

                    Text(item.title)
                        .font(.custom("IBMPlexSans-SemiBold", size: 16))
                        .foregroundColor(.darkText)

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
