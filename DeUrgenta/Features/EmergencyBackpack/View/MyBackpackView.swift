import SwiftUI

protocol MyBackpackViewDelegate {
    func myBackpackViewDidTapAddManager(_ view: MyBackpackView)
}

struct MyBackpackView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel

    var delegate: BackpackCategoryItemViewDelegate
    var myBackpackDelegate: MyBackpackViewDelegate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(AppStrings.MyBackpackView.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text(AppStrings.MyBackpackView.firstParagraph.localized())
                        .customFont(size: 16)

                    Text(AppStrings.MyBackpackView.secondParagraph.localized())
                        .customFont(size: 16)
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                VStack {
                    Divider()
                        .padding(.top, 10)

                    Button(action: {
                        myBackpackDelegate.myBackpackViewDidTapAddManager(self)
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accent)

                            Text(AppStrings.MyBackpackView.addManagerButton.localized())
                                .foregroundColor(.accent)
                                .customFont(.IBMPlexSansSemiBold, size: 20)
                        }
                        .padding(.vertical)

                        Spacer()

                        Image("chevron-right")
                            .renderingMode(.template)
                            .foregroundColor(.accent)
                            .padding(.trailing, 10)
                    })

                    Divider()
                }
                .padding(.bottom, 20)

                Text(AppStrings.MyBackpackView.backpackitemsHeader.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 20)
                    .padding(.vertical)

                LazyVStack {
                    ForEach(categoryViewModel.items, id: \.id) { item in
                        BackpackCategoryItemView(item: item, delegate: delegate)
                    }
                }

                Divider()

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
