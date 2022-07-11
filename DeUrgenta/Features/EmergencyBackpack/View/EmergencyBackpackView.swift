import SwiftUI

struct EmergencyBackpackView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fă-ți rucsacul de urgență")
                .font(.custom("IBMPlexSans-SemiBold", size: 23))

            ScrollView {
                Text("Rucsacul de urgență conține obiecte, alimente și alte lucruri utile care vă vor ajuta să supraviețuiți cel puțin 72 de ore într-o situație critică. În pașii următori vei afla ce trebuie să conțină acest rucsac, să te asiguri că ai minimul necesar adăugat în el și poți să alegi cine dintre persoanele cu care locuiești este responsabil de actualizarea sa. ")
                    .foregroundColor(.darkText)
                    .lineSpacing(10)
                    .padding(.vertical, 10)

                Divider()

                Button(action: {
                    // TODO: Implement this action
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
                    // TODO: Implement this action
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
