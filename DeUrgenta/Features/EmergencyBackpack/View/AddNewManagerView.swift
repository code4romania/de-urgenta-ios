import SwiftUI

struct AddNewManagerView: View {
    @State private var transferResourcesInNewBackpack = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Adaugă responsabil nou")
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text("Această acțiune va crea un nou rucsac în profilul tau pentru a-l putea împărți cu alte persoane cu care locuiești. Poți invita noi responsabili fie dintre persoanele care sunt parte din grupul/grupurile tale sau o persoană complet nouă.")
                        .modifier(PrimaryTextStyle())

                    Text("Pare că ai adăugat deja resurse în rucsac. Bifează mai jos dacă vrei să transferi resursele din rucsacul tău în noul rucsac pe care îl împarți cu alte persoane.")
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                Toggle(isOn: $transferResourcesInNewBackpack, label: {
                    Text("Transferă resurse în noul rucsac")
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.black)
                })
                .padding(.vertical)

                Text("Alege responsabil")
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

                            Text(AppStrings.MyBackpackView.addManagerButton.localized())
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
