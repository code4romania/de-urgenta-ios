import Foundation

class AccountConfigViewModel: ObservableObject {
    @Published var steps: [ConfigStep] = []

    init() {
        steps = [ConfigStep(name: "Configurează adresele",
                            logo: "config.map-icon", enabled: true),

                 ConfigStep(name: "Creează-ți grupul",
                            logo: "config.group-icon", enabled: false),

                 ConfigStep(name: "Fă-ți rucsacul de urgență",
                            logo: "config.bag-icon", enabled: false),

                 ConfigStep(name: "Învață să dai primul ajutor",
                            logo: "config.red-cross-icon", enabled: false)]
    }
}
