import SwiftUI

struct AddItemSection: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Nume produs")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField("Introdu nume produs", text: $categoryViewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text("Cantitate")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField("1", value: $categoryViewModel.quantity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text("Expira la:")
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                DatePicker(selection: $categoryViewModel.expirationDate, in: Date()..., displayedComponents: .date) {}
                    .datePickerStyle(.automatic)
                    .labelsHidden()
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical)
        .onAppear {
            categoryViewModel.name = ""
        }
    }
}
