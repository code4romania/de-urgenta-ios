import SwiftUI

struct ItemView: View {
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

                Text("Sterge")
                    .modifier(PrimaryTextStyle())
            }

            HStack {
                Text("Expira la:   ")
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

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(name: "Seminte", quantity: 20, expirationDate: Date()))
    }
}
