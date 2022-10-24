import SwiftUI

protocol CreateGroupViewDelegate {
    func createGroupViewDidTapAddGroup(_ view: CreateGroupView)
    func createGroupViewDidTapNoGroup(_ view: CreateGroupView)
}

struct CreateGroupView: View {
    var delegate: CreateGroupViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.CreateGroup.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.leading, 20)
                    .padding(.top, 10)

                Spacer()
            }

            VStack {
                ScrollView(showsIndicators: false) {
                    Text(AppStrings.CreateGroup.firstParagraph.localized())
                        .customFont(size: 16)
                        .foregroundColor(.darkText)

                    Text(AppStrings.CreateGroup.secondParagraph.localized())
                        .padding(.top, 15)
                        .customFont(size: 16)
                        .foregroundColor(.darkText)
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            .lineSpacing(10)

            Spacer()

            VStack {
                Button(action: {
                    delegate.createGroupViewDidTapNoGroup(self)
                }, label: {
                    Text(AppStrings.CreateGroup.noGroup.localized())
                        .foregroundColor(.gray)
                        .underline()
                })

                Button(action: {
                    delegate.createGroupViewDidTapAddGroup(self)
                }, label: {
                    HStack {
                        Text(AppStrings.CreateGroup.addGroup.localized())
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)

                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)

                })
            }
            .padding(.bottom, 30)
            .padding(.horizontal)
        }
        .navigationBarHidden(false)
    }
}
