import SwiftUI

struct MyBackpackView: View {
    let items = [
        BackpackItem(title: "Apa si alimente"),
        BackpackItem(title: "Articole de igiena"),
        BackpackItem(title: "Trusa de prim ajutor"),
        BackpackItem(title: "Documente"),
        BackpackItem(title: "Articole de supravietuire"),
        BackpackItem(title: "Diverse"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Rucsacul meu")
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .padding(.vertical, 10)

                VStack {
                    Text("Există o serie de itemuri pe care este recomandat să le ai în acest rucsac. Chiar dacă nu ai acum rucsacul, pune deoparte  resursele de mai jos până vei achiziționa unul. Este recomandat să ai un rucsac impermeabil sau dintr-un material cât mai rezistent.")
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)

                    Text(" Rucsacul este responsabilitatea tuturor persoanelor care locuiesc în aceeași casă. Dacă locuiești cu încă cineva, invită-l în aplicație și asigurați-vă împreună că aveți mereu tot ce este necesar în rucsac.  ")
                        .font(.custom("IBMPlexSans-Regular", size: 16))
                        .foregroundColor(.darkText)
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                VStack {
                    Divider()
                        .padding(.top, 10)

                    Button(action: {
                        // TODO: Implement this action
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accent)

                            Text("Adauga un responsabil")
                                .font(.custom("IBMPlexSans-SemiBold", size: 20))
                                .foregroundColor(.accent)
                        }
                        .padding(.vertical)

                        Spacer()

                        Image("chevron-right")
                            .foregroundColor(.accent)
                            .padding(.trailing, 10)
                    })

                    Divider()
                }
                .padding(.bottom, 20)

                Text("Componentele rucsacului")
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .padding(.vertical)

                LazyVStack {
                    ForEach(items, id: \.id) { item in
                        BackpackItemView(item: item)
                    }
                }

                Divider()

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}