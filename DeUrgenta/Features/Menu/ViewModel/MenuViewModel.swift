import Foundation

class MenuViewModel: ObservableObject {
    let options = [
        MenuOption(name: "Adrese și trasee", type: .adress),
        MenuOption(name: "Grupuri de urgență", type: .grups),
        MenuOption(name: "Rucsacul de urgență", type: .backpack),
        MenuOption(name: "Cursuri și informații utile", type: .courses),
        MenuOption(name: "Profilul meu", type: .myaccount),
        MenuOption(name: "Setări", type: .settings),
        MenuOption(name: "Despre aplicație", type: .about),
        MenuOption(name: "Delogare", type: .signout),
    ]
}
