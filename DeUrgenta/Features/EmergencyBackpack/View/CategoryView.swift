import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel
    @State var showingAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryViewModel.selectedCategory?.title ?? "")
                .font(.custom("IBMPlexSans-SemiBold", size: 23))
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            ScrollView {
                ArrayView(categoryViewModel: categoryViewModel)
                    .isHidden(!categoryViewModel.hasItem, remove: true)

                AddItemSection(categoryViewModel: categoryViewModel)
                    .isHidden(categoryViewModel.hasItem && categoryViewModel.hideSection)
            }

            Spacer()

            VStack {
                Button(action: {
                    if categoryViewModel.name.isEmpty, !categoryViewModel.hideSection {
                        showingAlert = true
                    } else {
                        if !categoryViewModel.hideSection {
                            categoryViewModel.addItem()
                            categoryViewModel.hideSection = true
                        } else if categoryViewModel.hideSection {
                            categoryViewModel.hideSection = false
                        }
                    }
                }, label: {
                    HStack {
                        Image(systemName: "plus")

                        Text(categoryViewModel.hideSection ? AppStrings.CategoryView.addItemButton.localized() : AppStrings.CategoryView.saveItemButton.localized())
                            .font(.custom("IBMPlexSans-Bold", size: 16))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(categoryViewModel.name.isEmpty && !categoryViewModel.hideSection ? Color.fieldBorder : Color.accent)
                    .foregroundColor(Color.secondary)
                    .cornerRadius(6)
                })
            }
            .padding(.bottom, 30)
            .padding(.horizontal)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(AppStrings.CategoryView.alertTitle.localized()),
                      message: Text(AppStrings.CategoryView.alertMessage.localized()),
                      dismissButton: .default(Text(AppStrings.CategoryView.alertButton.localized())))
            }
        }
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }

    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
