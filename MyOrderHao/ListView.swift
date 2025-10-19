// Code by Hao Nguyen, 991521091

import SwiftData
import SwiftUI

struct ListView: View {
    @State var showAddView = false
    @Environment(\.modelContext) var context
    @Query(sort: \Order.orderDate, order: .reverse) var orders: [Order]

    var body: some View {
        NavigationStack {
            // Hide Back button and add link to Add view
            NavigationLink(destination: ContentView(), isActive: $showAddView) {
                EmptyView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                trailing: Button("Add Order") {
                    showAddView = true
                }
            )

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

                    List {
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
                            }
                            .listRowBackground(
                                index == 1
                                    ? Color.gray.opacity(0).clipShape(.rect(cornerRadius: 5))
                                    : Color.gray.opacity(0.2).clipShape(.rect(cornerRadius: 5))
                            )
                        }
                        .onDelete(perform: deleteItem)
                        .cornerRadius(5)
                    }
                    .listStyle(.plain)
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

    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let order = orders[index]
            context.delete(order)
            print("Order \(order.id) deleted")
        }
        do {
            try context.save()
        } catch {
            print("Can't delete order: \(error)")
        }
    }
}
