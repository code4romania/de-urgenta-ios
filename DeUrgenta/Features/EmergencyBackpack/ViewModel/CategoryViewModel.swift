import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var quantity: Int = 1
    @Published var expirationDate: Date = .init()

    @Published var selectedCategory: CategoryItem?
    @Published var currentItemsArray: [Item] = []

    @Published var hasItem: Bool = false
    @Published var hideSection: Bool = false

    init(selectedCategory: CategoryItem? = nil) {
        self.selectedCategory = selectedCategory
    }

    let items = [
        CategoryItem(title: AppStrings.CategoryItem.foodTitle.localized(), icon: "icon-syrup", type: .food),
        CategoryItem(title: AppStrings.CategoryItem.hygieneItemsTitle.localized(), icon: "icon-cotton-swabs", type: .hygieneItems),
        CategoryItem(title: AppStrings.CategoryItem.firstAidKitTitle.localized(), icon: "icon-capsules", type: .firstAidKit),
        CategoryItem(title: AppStrings.CategoryItem.docsTitle.localized(), icon: "icon-prescription", type: .docs),
        CategoryItem(title: AppStrings.CategoryItem.survivalItemsTitle.localized(), icon: "icon-medical-mask", type: .survivalItems),
        CategoryItem(title: AppStrings.CategoryItem.mixedTitle.localized(), icon: "icon-pharmacy", type: .mixed),
    ]

    func addItem() {
        if let selectedCategory = selectedCategory {
            currentItemsArray.append(Item(name: name, quantity: quantity, expirationDate: expirationDate))

            self.selectedCategory = CategoryItem(id: selectedCategory.id,
                                                 title: selectedCategory.title,
                                                 icon: selectedCategory.icon,
                                                 type: selectedCategory.type,
                                                 itemsArray: currentItemsArray)

            if checkItems() {
                hasItem = true
            }
        }
    }

    func removeItem(currentItem: Item) {
        currentItemsArray.removeAll { item in
            item.id == currentItem.id
        }
    }

    private func checkItems() -> Bool {
        guard let selectedCategory = selectedCategory else {
            return false
        }
        return !selectedCategory.itemsArray.isEmpty
    }
}
