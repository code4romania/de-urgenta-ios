import SwiftUI

struct MyBackpackView: View {
    let items = [
        CategoryItem(title: AppStrings.CategoryItem.foodTitle.localized(), icon: "icon-syrup", type: .food),
        CategoryItem(title: AppStrings.CategoryItem.hygieneItemsTitle.localized(), icon: "icon-cotton-swabs", type: .hygieneItems),
        CategoryItem(title: AppStrings.CategoryItem.firstAidKitTitle.localized(), icon: "icon-capsules", type: .firstAidKit),
        CategoryItem(title: AppStrings.CategoryItem.docsTitle.localized(), icon: "icon-prescription", type: .docs),
        CategoryItem(title: AppStrings.CategoryItem.survivalItemsTitle.localized(), icon: "icon-medical-mask", type: .survivalItems),
        CategoryItem(title: AppStrings.CategoryItem.mixedTitle.localized(), icon: "icon-pharmacy", type: .mixed),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(AppStrings.MyBackpackView.headerTitle.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text(AppStrings.MyBackpackView.firstParagraph.localized())
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)

                    Text(AppStrings.MyBackpackView.secondParagraph.localized())
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                VStack {
                    Divider()
                        .padding(.top, 10)

                    Button(action: {
                        // TODO: Implement this action
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accent)

                            Text(AppStrings.MyBackpackView.addManagerButton.localized())
                                .font(.custom("IBMPlexSans-SemiBold", size: 20))
                                .foregroundColor(.accent)
                        }
                        .padding(.vertical)

                        Spacer()

                        Image("chevron-right")
                            .foregroundColor(.accent)
                            .padding(.trailing, 10)
                    })

                    Divider()
                }
                .padding(.bottom, 20)

                Text(AppStrings.MyBackpackView.backpackitemsHeader.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .padding(.vertical)

                LazyVStack {
                    ForEach(items, id: \.id) { item in
                        BackpackItemView(item: item)
                    }
                }

                Divider()

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
