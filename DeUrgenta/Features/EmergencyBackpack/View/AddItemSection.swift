import SwiftUI

struct AddItemSection: View {
    @State var itemName: String = ""
    @State var itemQuantity: Int = 1
    @State var expirationDate: Date = .init()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Nume produs")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField("Introdu nume produs", text: $itemName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text("Cantitate")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField("1", value: $itemQuantity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text("Expira la:")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                DatePicker(selection: $expirationDate, in: Date()..., displayedComponents: .date) {}
                    .datePickerStyle(.automatic)
                    .labelsHidden()
            }
            .frame(width: .infinity)
            .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical)
    }
}

struct AddItemSection_Previews: PreviewProvider {
    static var previews: some View {
        AddItemSection()
    }
}
