import SwiftUI

protocol AccountConfigViewDelegate {
    func accountConfigViewShouldRedirect(_ view: AccountConfigView, _ item: ConfigStep)
}

struct AccountConfigView: View {
    @StateObject var viewModel = AccountConfigViewModel()
    var delegate: AccountConfigViewDelegate

    var body: some View {
        VStack(spacing: 0) {
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
                    delegate.accountConfigViewShouldRedirect(self, item)
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
