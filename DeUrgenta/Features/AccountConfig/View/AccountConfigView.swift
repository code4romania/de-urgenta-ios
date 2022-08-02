import SwiftUI

protocol AccountConfigViewDelegate {
    func accountConfigViewShouldRedirect(from view: AccountConfigView, withItem item: ConfigStep)
    func accountConfigViewDidTapMenuButton(_ view: AccountConfigView)
}

struct AccountConfigView: View {
    @StateObject var viewModel = AccountConfigViewModel()
    var delegate: AccountConfigViewDelegate

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()

                Button(action: {
                    delegate.accountConfigViewDidTapMenuButton(self)
                }, label: {
                    Image("config.menu-icon")
                        .frame(width: 21, height: 16)
                        .foregroundColor(.accent)
                })
            }

            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)

                Spacer()
            }

            Text(AppStrings.AccountConfig.headerTitle.localized())
                .foregroundColor(.darkText)
                .font(.custom("IBMPlexSans-Bold", size: 36))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 30)

            ForEach(viewModel.steps) { item in
                Button(action: {
                    delegate.accountConfigViewShouldRedirect(from: self, withItem: item)
                }, label: {
                    ConfigStepView(step: item)
                        .padding(.bottom, 24)
                        .disabled(!item.enabled)
                })
            }

            Spacer()
        }.padding(.horizontal, 20)
    }
}
