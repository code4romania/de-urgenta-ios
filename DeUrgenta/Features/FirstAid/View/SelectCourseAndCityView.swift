import SwiftUI

struct SelectCourseAndCityView: View {
    @ObservedObject var locationManager: LocationViewModel

    var body: some View {
        HStack {
            Text(AppStrings.SelectCourseAndCityView.headerTitle.localized())
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            Spacer()
        }

        VStack(alignment: .leading) {
            Text(AppStrings.SelectCourseAndCityView.firstSelectorheader.localized())
                .customFont(size: 14)

            DropdownSelector(
                locationManager: locationManager,
                type: .course,
                options: locationManager.courses,
                imageIcon: "book.fill",
                onOptionSelected: { option in
                    print(option)
                }
            )
            .zIndex(1)

            Text(AppStrings.SelectCourseAndCityView.secondSelectorheader.localized())
                .customFont(size: 14)
                .padding(.top, 15)

            DropdownSelector(
                locationManager: locationManager,
                type: .location,
                options: locationManager.locations,
                imageIcon: "map.fill",
                onOptionSelected: { option in
                    print(option)
                }
            )

            Spacer()

            Button(action: {
                // TODO: Implement this action
            }, label: {
                HStack {
                    Text(AppStrings.SelectCourseAndCityView.viewCoursesButton.localized())
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
            .padding(.bottom, 20)
        }
        .padding(.horizontal)

        Spacer()
    }
}
