// Code by Hao Nguyen, 991521091

import SwiftUI

struct ListView: View {
    @Binding var list: [Order]

    var body: some View {
        VStack {
            Text("Total of orders: \(list.count)")
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
                }
                .bold()

                // Column data
                ForEach(list, id: \.self) { item in
                    HStack {
                        Text(item.size.rawValue).frame(maxWidth: .infinity)
                        Text(item.toppings.rawValue).frame(maxWidth: .infinity)
                        Text(item.crust.rawValue).frame(maxWidth: .infinity)
                        Text("\(item.quantity)").frame(maxWidth: .infinity).bold()
                    }
                }
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
