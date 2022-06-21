import SwiftUI

protocol CreateGroupViewDelegate {
    func CreateGroupViewDidTapAddGroup(_ view: CreateGroupView)
    func CreateGroupViewDidTapNoGroup(_ view: CreateGroupView)
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
                Text(AppStrings.CreateGroup.firstParagraph.localized())
                    .font(.custom("IBMPlexSans-Regular", size: 16))
                    .foregroundColor(.darkText)

                Text(AppStrings.CreateGroup.secondParagraph.localized())
                    .padding(.top, 15)
                    .font(.custom("IBMPlexSans-Regular", size: 16))
                    .foregroundColor(.darkText)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 5)
            .lineSpacing(10)

            Spacer()

            VStack {
                Button(action: {
                    delegate.CreateGroupViewDidTapNoGroup(self)
                }, label: {
                    Text(AppStrings.CreateGroup.noGroup.localized())
                        .foregroundColor(.gray)
                        .underline()
                })

                Button(action: {
                    delegate.CreateGroupViewDidTapAddGroup(self)
                }, label: {
                    Text(AppStrings.CreateGroup.addGroup.localized())
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity)
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
