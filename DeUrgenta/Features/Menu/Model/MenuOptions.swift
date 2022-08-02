import Foundation

enum OptionType {
    case adress
    case grups
    case backpack
    case courses
    case myaccount
    case settings
    case about
    case signout
}

struct MenuOption: Identifiable {
    var id: UUID = .init()
    var name: String
    var type: OptionType
}
