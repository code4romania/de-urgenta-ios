import SwiftUI

struct ValidationAccountView: View {
    var body: some View {
        VStack {
            HStack{
                Image("icon-envelope-large")
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 100)

            Text("Valideaza-ti contul")
                .foregroundColor(.darkText)
                .customFont( .IBMPlexSansBold,size: 36)
                .padding(.vertical)
            
            
            Text("Un e-mail a fost trimis catre adresa pe care ti-ai facut contul bla bla te rugam sa apesi linkul pt validarea contului etc.")
                .foregroundColor(.darkText)
                .customFont(size: 16)
                .lineSpacing(5)
                .padding(.horizontal)
                
            
            Spacer()
        }
        .padding()
    }
}

struct ValidationAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationAccountView()
    }
}
