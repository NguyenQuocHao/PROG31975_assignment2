// Code by Hao Nguyen, 991521091

import SwiftData
import SwiftUI

struct ContentView: View {
    @State var order: Order = Order.getDefault()
    @Environment(\.modelContext) var context
    @Query(sort: \Order.id) var orders: [Order]
    @State var showConfirm = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Brand name
                Text("PIZZA WOOH!!")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                    .bold()

                VStack(spacing: 10) {
                    Form {
                        Picker("Select a size", selection: $order.size) {
                            ForEach(PizzaSize.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }

                        Picker("Select a topping", selection: $order.toppings) {
                            ForEach(ToppingOption.allCases, id: \.self) {
                                option in
                                Text(option.rawValue).tag(option)
                            }
                        }

                        Text("Select crust")
                        Picker("", selection: $order.crust) {
                            ForEach(CrustType.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)

                        Stepper(
                            "Select number: \(order.quantity)",
                            value: $order.quantity,
                            in: 1...100
                        )

                        Button("Save Order") {
                            showConfirm = true
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .scrollContentBackground(.hidden)
                    .background(.orange)
                    .alert(isPresented: $showConfirm) {
                        Alert(
                            title: Text(
                                "Confirm"
                            ),
                            message: Text(
                                "Size: \(order.size.rawValue)\nCrust: \(order.crust.rawValue)\nToppings: \(order.toppings.rawValue)\nQuantity: \(order.quantity)"
                            ),
                            primaryButton: .default(
                                Text("Cancel"),
                            ),
                            secondaryButton: .default(
                                Text("OK"),
                                action: save
                            )
                        )
                    }

                    Text("Number of orders: \(orders.count)")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(.orange)
                        .bold()
                }

                Spacer()

                // Navigation button
                NavigationLink(destination: ListView()) {
                    Text("Show My Order\(orders.count > 1 ? "s" : "")")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(
                            Color.blue.clipShape(.rect(cornerRadius: 15))
                        )
                }
            }
            .padding(.horizontal)
            .background(Color.orange.ignoresSafeArea())
        }
    }

    func save() {
        context.insert(order)
        do {
            try context.save()
            print("New order saved")
        } catch {
            print("Can't save new order: \(error)")
        }

        order = Order.getDefault()
    }
}

#Preview {
    ContentView()
}
