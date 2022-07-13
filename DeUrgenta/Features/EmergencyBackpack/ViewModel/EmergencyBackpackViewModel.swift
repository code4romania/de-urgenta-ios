import Foundation

class EmergencyBackpackViewModel: ObservableObject {
    let items = [
        CategoryItem(title: AppStrings.CategoryItem.foodTitle.localized(), icon: "icon-syrup", type: .food),
        CategoryItem(title: AppStrings.CategoryItem.hygieneItemsTitle.localized(), icon: "icon-cotton-swabs", type: .hygieneItems),
        CategoryItem(title: AppStrings.CategoryItem.firstAidKitTitle.localized(), icon: "icon-capsules", type: .firstAidKit),
        CategoryItem(title: AppStrings.CategoryItem.docsTitle.localized(), icon: "icon-prescription", type: .docs),
        CategoryItem(title: AppStrings.CategoryItem.survivalItemsTitle.localized(), icon: "icon-medical-mask", type: .survivalItems),
        CategoryItem(title: AppStrings.CategoryItem.mixedTitle.localized(), icon: "icon-pharmacy", type: .mixed),
    ]
}
