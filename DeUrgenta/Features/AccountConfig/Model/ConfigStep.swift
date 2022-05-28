import Foundation

struct ConfigStep: Identifiable {
    let id = UUID()
    let name: String
    let logo: String
    let enabled: Bool
}
