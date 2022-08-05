import SwiftUI

protocol FirstAidIntroViewDelegate {
    func firstAidIntroViewDidTapButton(_ view: FirstAidIntroView)
}

struct FirstAidIntroView: View {
    @ObservedObject var locationManager: LocationViewModel
    var delegate: FirstAidIntroViewDelegate

    var body: some View {
        HStack {
            Text(AppStrings.FirstAidIntroView.headerTitle.localized())
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            Spacer()
        }

        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    Text(AppStrings.FirstAidIntroView.firstParagraph.localized())
                        .customFont(size: 16)

                    Text(AppStrings.FirstAidIntroView.secondParagraph.localized())
                        .customFont(size: 16)
                        .padding(.top, 15)

                    Text(AppStrings.FirstAidIntroView.thirdParagraph.localized())
                        .customFont(size: 16)
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)
            }

            Spacer()

            Button(action: {
                locationManager.requestAuthorization()
                delegate.firstAidIntroViewDidTapButton(self)
            }, label: {
                HStack {
                    Text(AppStrings.FirstAidIntroView.viewCoursesButton.localized())
                        .foregroundColor(.secondary)
                        .customFont(.IBMPlexSansBold, size: 16)

                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.accent)
                .cornerRadius(6)
            })
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}
