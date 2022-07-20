import SwiftUI

struct AddItemSection: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(AppStrings.AddItemSection.addNameLabel.localized())
                    .modifier(SecondaryTextStyle())

                TextField(AppStrings.AddItemSection.addNamePlaceholder.localized(), text: $categoryViewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text(AppStrings.AddItemSection.quantityLabel.localized())
                    .modifier(SecondaryTextStyle())

                TextField(AppStrings.AddItemSection.quantityPlaceholder.localized(), value: $categoryViewModel.quantity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text(AppStrings.AddItemSection.expirationDateLabel.localized())
                    .modifier(SecondaryTextStyle())

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
