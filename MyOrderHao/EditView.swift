// Code by Hao Nguyen, 991521091

import SwiftData
import SwiftUI

struct EditView: View {
    var order: Order = Order.getDefault()
    @Environment(\.modelContext) var context
    @Query(sort: \Order.id) var orders: [Order]
    @State var shouldNavigate = false
    @State var showUpdateAlert = false
    @State var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Brand name
                Text("PIZZA WOOH!!")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                    .bold()

                Text("Order: \(order.id)")
                    .bold()

                VStack(spacing: 0) {
                    Form {
                        Picker(
                            "Select a size",
                            selection: Binding(
                                get: { order.size },
                                set: { order.size = $0 }
                            )
                        ) {
                            ForEach(PizzaSize.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .disabled(true)

                        Picker(
                            "Select a topping",
                            selection: Binding(
                                get: { order.toppings },
                                set: { order.toppings = $0 }
                            )
                        ) {
                            ForEach(ToppingOption.allCases, id: \.self) {
                                option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .disabled(true)

                        Text("Select crust")
                        Picker(
                            "",
                            selection: Binding(
                                get: { order.crust },
                                set: { order.crust = $0 }
                            )
                        ) {
                            ForEach(CrustType.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        .disabled(true)

                        Stepper(
                            "Select number: \(order.quantity)",
                            value: Binding(
                                get: { order.quantity },
                                set: { order.quantity = $0 }
                            ),
                            in: 1...100
                        )

                        Button("Update") {
                            do {
                                try context.save()
                                print("saved")
                                showUpdateAlert = true
                            } catch {
                                print("error")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .alert(isPresented: $showUpdateAlert) {
                            Alert(
                                title: Text("Successfully updated"),
                            )
                        }

                        Button("Delete") {
                            showDeleteAlert = true
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text(
                                    "Do you really want to delete this order?"
                                ),
                                primaryButton: .default(
                                    Text("Cancel"),
                                ),
                                secondaryButton: .destructive(
                                    Text("Delete"),
                                    action: delete
                                )
                            )
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.orange)
                }
                Text(
                    "Order Date: \(order.orderDate.formatted(date: .abbreviated, time: .standard))"
                )

                Spacer()

                NavigationLink(
                    destination: ListView(),
                    isActive: $shouldNavigate,
                    label: { EmptyView() }
                )
                .hidden()
            }
            .padding(.horizontal)
            .background(Color.orange.ignoresSafeArea())
        }
    }

    func delete() {
        do {
            context.delete(order)

            try context.save()
            print("saved")

            shouldNavigate = true
        } catch {
            print("error")
        }
    }
}

#Preview {
    ContentView()
}
