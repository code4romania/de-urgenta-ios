import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryViewModel.selectedCategory?.title ?? "")
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            ScrollView {
                BackpackItemsArrayView(categoryViewModel: categoryViewModel)
                    .isHidden(!categoryViewModel.hasItem, remove: true)

                AddItemSection(categoryViewModel: categoryViewModel)
                    .isHidden(categoryViewModel.hasItem && categoryViewModel.hideSection)
            }

            Spacer()

            VStack {
                Button(action: {
                    categoryViewModel.addItemAndSectionControl()
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(Color.secondary)

                        Text(categoryViewModel.hideSection ? AppStrings.CategoryView.addItemButton.localized() : AppStrings.CategoryView.saveItemButton.localized())
                            .foregroundColor(Color.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(categoryViewModel.name.isEmpty && !categoryViewModel.hideSection ? Color.fieldBorder : Color.accent)
                    .cornerRadius(6)
                })
            }
            .padding(.bottom, 30)
            .padding(.horizontal)
            .alert(isPresented: $categoryViewModel.showingAlert) {
                Alert(title: Text(AppStrings.CategoryView.alertTitle.localized()),
                      message: Text(AppStrings.CategoryView.alertMessage.localized()),
                      dismissButton: .default(Text(AppStrings.CategoryView.alertButton.localized())))
            }
        }
    }
}
