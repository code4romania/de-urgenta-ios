import Foundation

struct CategoryItem: Identifiable {
    var id: UUID = .init()
    var title: String
    var icon: String
    var type: CategoryType
}

enum CategoryType {
    case food
    case hygieneItems
    case firstAidKit
    case docs
    case survivalItems
    case mixed
}
