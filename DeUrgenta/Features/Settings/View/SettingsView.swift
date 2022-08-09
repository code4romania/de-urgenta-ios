import SwiftUI

protocol SettingsViewDelegate {
    func settingsViewShouldRedirect(from view: SettingsView, withItem item: SettingsOption)
}

struct SettingsView: View {
    var viewModel: SettingsViewModel
    var delegate: SettingsViewDelegate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Setări")
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)
                    .padding(.horizontal)

                ForEach(viewModel.settingsOptions, id: \.self) { option in
                    Button(action: {
                        delegate.settingsViewShouldRedirect(from: self, withItem: option)
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(option.name)
                                .customFont(.IBMPlexSansSemiBold, size: 16)
                                .padding()

                            Divider()
                        }
                    })
                }
            }
        }
    }
}
