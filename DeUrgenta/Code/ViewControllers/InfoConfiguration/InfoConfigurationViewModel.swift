//
//  InfoConfigurationViewModel.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 03.04.2021.
//

import Foundation
import Promises

class InfoConfigurationViewModel: NSObject {
    
    var hasConfiguredAddresses = false
    
    enum HeaderType {
        case welcome(name: String)
        case `default`
    }
    
    var headerType: HeaderType = .default
}
