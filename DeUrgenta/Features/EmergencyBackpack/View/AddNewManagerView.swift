import SwiftUI

struct AddNewManagerView: View {
    @State private var transferResourcesInNewBackpack = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(AppStrings.AddNewManagerView.headerTitle.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text(AppStrings.AddNewManagerView.firstParagraph.localized())
                        .modifier(PrimaryTextStyle())

                    Text(AppStrings.AddNewManagerView.secondParagraph.localized())
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                Toggle(isOn: $transferResourcesInNewBackpack, label: {
                    Text(AppStrings.AddNewManagerView.toggleLabel.localized())
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.black)
                })
                .padding(.vertical)

                Text(AppStrings.AddNewManagerView.addManagerHeader.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .foregroundColor(.darkText)
                    .padding(.vertical)

                VStack {
                    Divider()
                        .padding(.top, 10)

                    Button(action: {
                        // TODO: Implement this action
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accent)

                            Text(AppStrings.AddNewManagerView.addManagerButton.localized())
                                .font(.custom("IBMPlexSans-SemiBold", size: 20))
                                .foregroundColor(.accent)
                        }
                        .padding(.vertical)

                        Spacer()

                        Image("chevron-right")
                            .renderingMode(.template)
                            .foregroundColor(.accent)
                            .padding(.trailing, 10)
                    })

                    Divider()
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct AddNewManagerView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewManagerView()
    }
}
