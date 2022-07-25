import SwiftUI

struct FirstAidIntroView: View {
    var body: some View {
        HStack {
            Text("Învață să dai primul ajutor")
                .font(.custom("IBMPlexSans-SemiBold", size: 23))
                .frame(alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal)

            Spacer()
        }

        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    Text("Este foarte important să poți să îi ajuți pe cei din jur într-o situație de urgență.")
                        .modifier(PrimaryTextStyle())

                    Text("Există două tipuri de cursuri de prim ajutor pe care le poți face. Primul se numește ”Prim ajutor calificat” și este un tip de curs pe care îl poți face doar la Inspectorajul Județean pentru Situații de Urgență. Al doilea tip este cel de prim-ajutor, pe care îl poți face la organizații precum Societatea Națională de Cruce Roșie sau alți furnizori de cursuri. Există de asemenea și cursuri de pregătire în caz de dezastre.")
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)

                    Text("Certificările de prim ajutor trebuie reînnointe la intervale diferite de timp. De Urgență te ajută să alegi un curs potrivit pentru tine și te va anunța când certificarea ta expiră pentru a reînnoi cursul. ")
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)
            }

            Spacer()

            Button(action: {
                //TODO: Implement this action
            }, label: {
                HStack {
                    Text("Vezi cursurile")
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
