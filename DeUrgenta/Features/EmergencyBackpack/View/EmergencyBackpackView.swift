import SwiftUI

protocol EmergencyBackpackViewDelegate {
    func emergencyBackpackViewDidTapAddBackpack(_ view: EmergencyBackpackView)
    func emergencyBackpackViewDidTapRemindMeLater(_ view: EmergencyBackpackView)
}

struct EmergencyBackpackView: View {
    var delegate: EmergencyBackpackViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            Text("Fă-ți rucsacul de urgență")
                .font(.custom("IBMPlexSans-SemiBold", size: 23))
                .padding(.top, 10)

            ScrollView {
                Text("Rucsacul de urgență conține obiecte, alimente și alte lucruri utile care vă vor ajuta să supraviețuiți cel puțin 72 de ore într-o situație critică. În pașii următori vei afla ce trebuie să conțină acest rucsac, să te asiguri că ai minimul necesar adăugat în el și poți să alegi cine dintre persoanele cu care locuiești este responsabil de actualizarea sa. ")
                    .font(.custom("IBMPlexSans-Regular", size: 16))
                    .foregroundColor(.darkText)
                    .lineSpacing(10)
                    .padding(.vertical, 10)

                Divider()
                    .padding(.top, 10)

                Button(action: {
                    delegate.emergencyBackpackViewDidTapAddBackpack(self)
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)

                        Text("Adauga un rucsac nou")
                            .font(.custom("IBMPlexSans-SemiBold", size: 20))
                            .foregroundColor(.darkText)
                    }
                    .padding(.vertical)

                    Spacer()

                    Image("chevron-right")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                })

                Divider()
            }

            Spacer()

            HStack {
                Spacer()

                Button(action: {
                    delegate.emergencyBackpackViewDidTapRemindMeLater(self)
                }, label: {
                    Text("Aminteste-mi mai tarziu")
                        .foregroundColor(.gray)
                        .underline()
                })

                Spacer()
            }
            .padding(.bottom, 45)
        }
        .padding(.horizontal)
    }
}
