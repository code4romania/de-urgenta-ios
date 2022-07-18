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
                ArrayView(itemsArray: categoryViewModel.selectedCategory?.itemsArray ?? [])
                    .isHidden(!categoryViewModel.hasItem, remove: true)

                if !categoryViewModel.hasItem {
                    AddItemSection(categoryViewModel: categoryViewModel)
                } else {
                    AddItemSection(categoryViewModel: categoryViewModel)
                        .isHidden(!categoryViewModel.showSection)
                    // isHidden(hasItems || !showSection)
                }
            }

            Spacer()

            VStack {
                Button(action: {
                    if categoryViewModel.hasItem, categoryViewModel.showSection == false {
                        categoryViewModel.showSection = true
                        return
                    } else if categoryViewModel.showSection {
                        categoryViewModel.addItem()
                        categoryViewModel.showSection = false
                    } else {
                        categoryViewModel.addItem()
                    }
                }, label: {
                    HStack {
                        Image(systemName: "plus")

                        Text(categoryViewModel.showSection ? "Salveaza produs" : "Adauga produs")
                            .font(.custom("IBMPlexSans-Bold", size: 16))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accent)
                    .foregroundColor(Color.secondary)
                    .cornerRadius(6)

                })
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
