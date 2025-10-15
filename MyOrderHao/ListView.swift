// Code by Hao Nguyen, 991521091

import SwiftData
import SwiftUI

struct ListView: View {
    @Query(sort: \Order.orderDate, order: .reverse) var orders: [Order]
    let formatter = DateFormatter()

    var body: some View {
        NavigationStack {

            VStack {
                // Brand name
                Text("PIZZA WOOH!!")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                    .bold()

                Text("Total of orders: \(orders.count)")
                    .font(.title2)
                    .padding(.bottom, 20)
                    .bold()

                VStack {
                    // Column titles
                    HStack {
                        Text("Size").frame(maxWidth: .infinity)
                        Text("Topping").frame(maxWidth: .infinity)
                        Text("Crust").frame(maxWidth: .infinity)
                        Text("Quantity").frame(maxWidth: .infinity)
                        Text("Date").frame(maxWidth: .infinity)
                    }
                    .bold()

                    if orders.count == 0 {
                        Text("You have 0 order.").padding(.top, 10)
                    }

                    // Column data
                    ForEach(orders.indices, id: \.self) { index in
                        NavigationLink(
                            destination: EditView(order: orders[index])
                        ) {
                            HStack {
                                Text(orders[index].size.rawValue).frame(
                                    maxWidth: .infinity
                                )
                                Text(orders[index].toppings.rawValue).frame(
                                    maxWidth: .infinity
                                )
                                Text(orders[index].crust.rawValue).frame(
                                    maxWidth: .infinity
                                )
                                Text("\(orders[index].quantity)").frame(
                                    maxWidth: .infinity
                                ).bold()
                                Text(
                                    "\(orders[index].orderDate.formatted(date: .numeric, time: .shortened))"
                                ).frame(maxWidth: .infinity)
                            }
                        }.background(
                            index == 1
                                ? Color.gray.opacity(0)
                                : Color.gray.opacity(0.2)
                        )
                    }.cornerRadius(5)
                }
                .padding()
                .background(Color.yellow.clipShape(.rect(cornerRadius: 5)))

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.orange)
        }
    }
}
