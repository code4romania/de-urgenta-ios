//
//  BigTitleLabel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.07.2021.
//

import SwiftUI

struct BigTitleLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.homeLarge)
            .foregroundColor(.mainForeground)
    }
}

struct BigTitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        BigTitleLabel(title: "Test")
    }
}
