//
//  BodyTextLabel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.07.2021.
//

import SwiftUI

struct BodyTextLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.appBody)
            .lineSpacing(6)
    }
}

struct BodyTextLabel_Previews: PreviewProvider {
    static var previews: some View {
        BodyTextLabel(text: "Testing text Testing text Testing text Testing text Testing text Testing text ")
    }
}
