//
//  ContentView.swift
//  MyOrderHao
//
//  Created by user275773 on 10/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var list: [Order] = []
    @State var order: Order = Order.getDefault()

    var body: some View {
        NavigationStack {
            Spacer()
            
            Text("Number of orders: \(list.count)")
            
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
                Picker(selection : $order.crust , label: Text("Select crust")){
                    ForEach(CrustType.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }.pickerStyle(.segmented)
                
                Stepper(
                    "Select number: \(order.quantity)",
                    value: $order.quantity,
                    in: 1...100
                )
                
                Button("Add to list") {
                    list.append(order)
                    order = Order.getDefault()
                }    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Spacer()
            
            NavigationLink(destination: ListView(list: $list)) {
                Text("Show My Order")
            }
        }
        .padding()
    }
}

//#Preview {
//    ContentView(order: Order)
//}
