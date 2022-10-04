import SwiftUI

struct InputFieldView: View {
    var label: String
    var isSecureField: Bool = false
    var errorMessage: String?
    var iconName: String?

    @Binding var fieldData: String
    @Binding var showError: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .customFont(size: 14)
                .foregroundColor(.darkText)

            HStack {
                if isSecureField {
                    SecureField("", text: $fieldData)
                        .autocapitalization(.none)
                } else {
                    TextField("", text: $fieldData)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }

                Spacer()

                if let iconName = iconName,
                   showError {
                    Image(systemName: iconName)
                        .foregroundColor(Color.accent)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(showError ? Color.accent : Color.fieldBorder, lineWidth: 1)
            )

            if let error = errorMessage,
               showError {
                Text(error)
                    .customFont(size: 14)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var email: String = ""
    @State static var showError = true

    static var previews: some View {
        InputFieldView(label: "E-mail",
                       errorMessage: "Parola ta trebuie sa aiba minimi 8 caractere.",
                       iconName: "exclamationmark.circle.fill",
                       fieldData: $email,
                       showError: $showError)
    }
}
