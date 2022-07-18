import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

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
                    if !categoryViewModel.hideSection {
                        categoryViewModel.addItem()
                        categoryViewModel.hideSection = true
                    } else if categoryViewModel.hideSection {
                        categoryViewModel.hideSection = false
                    }
                }, label: {
                    HStack {
                        Image(systemName: "plus")

                        Text(categoryViewModel.hideSection ? "Adauga produs" : "Salveaza produs")
                            .font(.custom("IBMPlexSans-Bold", size: 16))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(categoryViewModel.name.isEmpty && !categoryViewModel.hideSection ? Color.fieldBorder : Color.accent)
                    .foregroundColor(Color.secondary)
                    .cornerRadius(6)
                })
                .disabled(categoryViewModel.name.isEmpty && !categoryViewModel.hideSection)
            }
            .padding(.bottom, 30)
            .padding(.horizontal)
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
