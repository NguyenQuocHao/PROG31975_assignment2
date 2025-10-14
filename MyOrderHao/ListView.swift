// Code by Hao Nguyen, 991521091

import SwiftUI
import SwiftData

struct ListView: View {
    @Query(sort : \Order.id) var orders : [Order]
    
    var body: some View {
        NavigationStack{
            
            VStack {
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
                    
                    // Column data
                    ForEach(orders, id: \.self) { item in
                        NavigationLink(destination: EditView(order: item)) {
                            HStack {
                                Text(item.size.rawValue).frame(maxWidth: .infinity)
                                Text(item.toppings.rawValue).frame(maxWidth: .infinity)
                                Text(item.crust.rawValue).frame(maxWidth: .infinity)
                                Text("\(item.quantity)").frame(maxWidth: .infinity).bold()
                                Text("\(item.creationDate)").frame(maxWidth: .infinity)
                            }
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
}
