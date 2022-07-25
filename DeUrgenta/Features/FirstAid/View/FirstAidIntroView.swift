import SwiftUI

struct FirstAidIntroView: View {
    @StateObject var locationManager = LocationViewModel()
    var body: some View {
        HStack {
            Text(AppStrings.FirstAidIntroView.headerTitle.localized())
                .font(.custom("IBMPlexSans-SemiBold", size: 23))
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            Spacer()
        }

        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    Text(AppStrings.FirstAidIntroView.firstParagraph.localized())
                        .modifier(PrimaryTextStyle())

                    Text(AppStrings.FirstAidIntroView.secondParagraph.localized())
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)

                    Text(AppStrings.FirstAidIntroView.thirdParagraph.localized())
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)
            }

            Spacer()

            Button(action: {
                locationManager.requestAuthorization()
            }, label: {
                HStack {
                    Text(AppStrings.FirstAidIntroView.viewCoursesButton.localized())
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.secondary)

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
