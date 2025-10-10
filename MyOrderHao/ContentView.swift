// Code by Hao Nguyen, 991521091

import SwiftUI

struct ContentView: View {
    @State var list: [Order] = []
    @State var order: Order = Order.getDefault()

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
                            ForEach(ToppingOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }

                        Text("Select crust")
                        Picker(selection: $order.crust, label: Text("Select crust")) {
                            ForEach(CrustType.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)

                        Stepper("Select number: \(order.quantity)", value: $order.quantity, in: 1...100)

                        Button("Add to list") {
                            list.append(order)
                            order = Order.getDefault()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .scrollContentBackground(.hidden)
                    .background(.orange)

                    Text("Number of orders: \(list.count)")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(.orange)
                        .bold()
                }

                Spacer()

                // Navigation button
                NavigationLink(destination: ListView(list: $list)) {
                    Text("Show My Order")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.blue.clipShape(.rect(cornerRadius: 15)))
                }
            }
            .padding(.horizontal)
            .background(Color.orange.ignoresSafeArea())
        }
    }
}

#Preview {
    ContentView()
}
