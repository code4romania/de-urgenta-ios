import SwiftUI

struct ContactRow: View {
    var contact: ContactInfo

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .font(.custom("IBMPlexSans-Regular", size: 15))
                        .foregroundColor(.darkText)

                    Text("\(contact.phoneNumber?.stringValue ?? "")")
                        .font(.custom("IBMPlexSans-Regular", size: 15))
                        .foregroundColor(.gray)
                }
                .lineSpacing(2)

                Spacer()

                Button(action: {
                    sendMessage(contact: contact)
                }, label: {
                    Text(AppStrings.ContactRow.buttonText.localized())
                        .foregroundColor(Color.accent)
                        .padding(.bottom, 2)
                        .padding(.top, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.accent, lineWidth: 1)
                        )
                })
            }
            .padding(.vertical)
            .padding(.trailing, 2)
            .frame(height: 50)

            Divider()
        }
    }

    func sendMessage(contact: ContactInfo) {
        let sms = "sms:\(contact.phoneNumber?.stringValue ?? ""))&body=Prietena ta Corina Dobre te invita sa te alaturi grupului ei de prieteni pregatiti! Descarcă DeUrgenta de la http://deurgenta.ro/invite/d9a84aed5c39bc"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
    }
}
