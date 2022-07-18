import Foundation

struct CategoryItem: Identifiable {
    var id: UUID = .init()
    var title: String
    var icon: String
    var type: CategoryType
    var itemsArray: [Item] = []
}

enum CategoryType {
    case food
    case hygieneItems
    case firstAidKit
    case docs
    case survivalItems
    case mixed
}

struct Item: Identifiable {
    var id: UUID = .init()
    var name: String
    var quantity: Int
    var expirationDate: Date
}
