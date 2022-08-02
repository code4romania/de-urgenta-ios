import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)

                    Spacer()
                }
                .padding()

                ForEach(viewModel.options, id: \.self) { option in
                    VStack {
                        Button(action: {
                            // TODO: Implement this action
                        }, label: {
                            VStack(alignment: .leading) {
                                Text(option.name)
                                    .font(.custom("IBMPlexSans-Bold", size: 16))
                                    .foregroundColor(.darkText)
                                    .padding()

                                Divider()
                            }
                        })
                    }
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text("Soluție proiectată, dezvoltată și administrată de")
                        .font(.custom("IBMPlexSans-Regular", size: 14))
                        .foregroundColor(Color.gray)

                    Image("code4romania-icon")

                    Button(action: {
                        // TODO: Implement this action
                    }, label: {
                        HStack {
                            Text("Doneaza")
                                .font(.custom("IBMPlexSans-Bold", size: 16))
                                .foregroundColor(.secondary)
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.green)
                        .cornerRadius(6)
                    })
                    .padding(.vertical, 20)
                }
                .padding(.top, 80)
                .padding(.horizontal)
            }
        }
    }
}
