import SwiftUI

struct BackpackItemView: View {
    var item: BackpackItem

    var body: some View {
        VStack {
            Divider()

            Button(action: {
                // TODO: Implement this action
            }, label: {
                HStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: 50, height: 50)

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
