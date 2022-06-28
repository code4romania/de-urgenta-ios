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
                    .font(.custom("IBMPlexSans-SemiBold", size: 24))
                    .padding(.leading, 20)
                    .padding(.top, 10)

                Spacer()
            }

            VStack {
                ScrollView(showsIndicators: false) {
                    Text(AppStrings.CreateGroup.firstParagraph.localized())
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)

                    Text(AppStrings.CreateGroup.secondParagraph.localized())
                        .padding(.top, 15)
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
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
                            .font(.custom("IBMPlexSans-Bold", size: 16))
                            .foregroundColor(.secondary)

                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)

                })
            }
            .padding(.bottom, 30)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
}
