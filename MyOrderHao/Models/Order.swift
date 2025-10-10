// Code by Hao Nguyen, 991521091

enum PizzaSize: String, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

enum ToppingOption: String, CaseIterable {
    case none = "None"
    case cheese = "Cheese"
    case pepperoni = "Pepperoni"
    case veggie = "Veggie"
    case meatLovers = "Meat Lovers"
}

enum CrustType: String, CaseIterable {
    case thin = "Thin"
    case regular = "Regular"
    case thick = "Thick"
}

struct Order: Hashable {
    var size: PizzaSize
    var toppings: ToppingOption
    var crust: CrustType
    var quantity: Int = 0
    
    static func getDefault() -> Order {
        return Order(size: .medium, toppings: .none, crust: .regular, quantity: 1)
    }
}
