import SwiftUI

protocol GroupViewDelegate {
    func groupViewDidTapAddFriendsButton(_ view: GroupView)
}

struct GroupView: View {
    var delegate: GroupViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.GroupView.headerTitle.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .padding(.top, 10)

                Spacer()
            }

            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.accent)

                Text("Avengers32 (5/30)")
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))

                Spacer()
            }
            .padding(.vertical)

            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 50)

                Text("(Admin) Corina Dobre")
                    .font(.custom("IBMPlexSans-Regular", size: 16))
                    .foregroundColor(.darkText)

                Spacer()
            }

            Spacer()

            Button(action: {
                delegate.groupViewDidTapAddFriendsButton(self)
            }, label: {
                HStack {
                    Text(AppStrings.GroupView.addFriendsButton.localized())
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.secondary)

                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.accent)
                .cornerRadius(6)
            })
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}
