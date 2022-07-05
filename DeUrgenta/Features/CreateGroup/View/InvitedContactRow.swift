import SwiftUI

struct InvitedContactRow: View {
    var contact: ContactInfo

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    HStack(spacing: 1) {
                        Text("\(contact.firstName) \(contact.lastName)")

                        Text("(Invitatie trimisa)") // Localize text
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    HStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.accent)

                        Text("Elimina din grup") // Localize text
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)

            Divider()
        }
    }
}
