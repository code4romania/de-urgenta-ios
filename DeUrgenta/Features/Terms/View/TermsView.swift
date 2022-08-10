import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("LEGAL")
                    .foregroundColor(.accent)
                    .customFont(.IBMPlexSansMedium, size: 16)

                Text("Termeni și condiții")
                    .customFont(.IBMPlexSansSemiBold, size: 30)
                    .padding(.bottom, 15)

                Text("Aliquet nec orci mattis amet quisque ullamcorper neque, nibh sem. At arcu, sit dui mi, nibh dui, diam eget aliquam. Quisque id at vitae feugiat egestas ac. Diam nulla orci at in viverra scelerisque eget. Eleifend egestas fringilla sapien.")
                    .customFont(size: 16)
                    .lineSpacing(10)
                    .padding(.bottom, 15)

                Text("Faucibus commodo massa rhoncus, volutpat. Dignissim sed eget risus enim. Mattis mauris semper sed amet vitae sed turpis id. Id dolor praesent donec est. Odio penatibus risus viverra tellus varius sit neque erat velit. Faucibus commodo massa rhoncus, volutpat. Dignissim sed eget risus enim. Mattis mauris semper sed amet vitae sed turpis id.")
                    .customFont(size: 16)
                    .lineSpacing(10)
            }
            .padding()
        }
    }
}
