// Code by Hao Nguyen, 991521091

import SwiftData
import Foundation

@Model
class Order: Hashable {
    @Attribute(.unique)
    var id: UUID = UUID()
    var size: PizzaSize
    var toppings: ToppingOption
    var crust: CrustType
    var quantity: Int = 0
    var orderDate: Date

    init(
        size: PizzaSize,
        toppings: ToppingOption,
        crust: CrustType,
        quantity: Int
    ) {
        self.size = size
        self.toppings = toppings
        self.crust = crust
        self.quantity = quantity
        self.orderDate = Date()
    }

    static func getDefault() -> Order {
        return Order(
            size: .medium,
            toppings: .none,
            crust: .regular,
            quantity: 1
        )
    }
}
