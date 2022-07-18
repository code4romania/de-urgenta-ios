import SwiftUI

struct AddItemSection: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(AppStrings.AddItemSection.addNameLabel.localized())
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField(AppStrings.AddItemSection.addNamePlaceholder.localized(), text: $categoryViewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text(AppStrings.AddItemSection.quantityLabel.localized())
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField(AppStrings.AddItemSection.quantityPlaceholder.localized(), value: $categoryViewModel.quantity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)

                Text(AppStrings.AddItemSection.expirationDateLabel.localized())
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
