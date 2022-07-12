import Foundation

struct BackpackItem: Identifiable {
    var id: UUID = .init()
    var title: String
    var icon: String
}
