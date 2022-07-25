import Foundation

class AccountConfigViewModel: ObservableObject {
    @Published var steps: [ConfigStep] = []

    init() {
        steps = [ConfigStep(name: "Configurează adresele",
                            type: .adress,
                            logo: "config.map-icon",
                            enabled: true),

                 ConfigStep(name: "Creează-ți grupul",
                            type: .group,
                            logo: "config.group-icon",
                            enabled: false),

                 ConfigStep(name: "Fă-ți rucsacul de urgență",
                            type: .backpack,
                            logo: "config.bag-icon",
                            enabled: false),

                 ConfigStep(name: "Învață să dai primul ajutor",
                            type: .firstAid,
                            logo: "config.red-cross-icon",
                            enabled: false)]
    }
}
