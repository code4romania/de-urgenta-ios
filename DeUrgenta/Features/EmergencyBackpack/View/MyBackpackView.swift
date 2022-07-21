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
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text(AppStrings.MyBackpackView.firstParagraph.localized())
                        .modifier(PrimaryTextStyle())

                    Text(AppStrings.MyBackpackView.secondParagraph.localized())
                        .modifier(PrimaryTextStyle())
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
                                .font(.custom("IBMPlexSans-SemiBold", size: 20))
                                .foregroundColor(.accent)
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
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .foregroundColor(.darkText)
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
