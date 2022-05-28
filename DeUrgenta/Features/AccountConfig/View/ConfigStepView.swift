import SwiftUI

struct ConfigStepView: View {
    let step: ConfigStep

    var body: some View {
        HStack {
            Image(step.logo)
                .resizable()
                .frame(width: 16, height: 16)
                .padding(10)
                .overlay(Circle().stroke(Color.accent, lineWidth: 6))

            Text(step.name)
                .font(.custom("IBMPlexSans-Bold", size: 20))
                .padding(.leading, 4)

            Spacer()
            Image("chevron-right")
        }.opacity(step.enabled ? 1 : 0.4)
    }
}
