import SwiftUI

struct BackpackItemView: View {
    var item: CategoryItem

    var body: some View {
        VStack {
            Divider()

            Button(action: {
                // TODO: Implement this action
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
