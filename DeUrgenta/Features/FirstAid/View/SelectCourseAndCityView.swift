import SwiftUI

struct SelectCourseAndCityView: View {
    @ObservedObject var locationManager: LocationViewModel

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
            Text("Selectează tipul de curs")
                .modifier(SecondaryTextStyle())

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

            Text("Selectează orașul")
                .modifier(SecondaryTextStyle())
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
            .padding(.bottom, 20)
        }
        .padding(.horizontal)

        Spacer()
    }
}
