// Code by Hao Nguyen, 991521091

import SwiftUI
import SwiftData

struct EditView: View {
    var order: Order = Order.getDefault()
    @Environment(\.modelContext) var context
    @Query(sort : \Order.id) var orders : [Order]
    @State var tempOrder = Order.getDefault()
    @State var shouldNavigate = false
    
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
                
                VStack(spacing: 10) {
                    Form {
                        Picker("Select a size", selection: Binding(
                            get: { order.size },
                            set: { order.size = $0 }
                        )) {
                            ForEach(PizzaSize.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        
                        Picker("Select a topping", selection: Binding(
                            get: { order.toppings },
                            set: { order.toppings = $0 }
                        )) {
                            ForEach(ToppingOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        
                        Text("Select crust")
                        Picker("Select crust", selection: Binding(
                            get: { order.crust },
                            set: { order.crust = $0 }
                        )) {
                            ForEach(CrustType.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Stepper("Select number: \(order.quantity)", value: Binding(
                            get: { order.quantity },
                            set: { order.quantity = $0 }
                        ), in: 1...100)
                        
                        Button("Update") {
                            do{
                                try context.save()
                                print("saved")
                            } catch {
                                print("error")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        Button("Delete") {
                            do{
                                context.delete(order)
                                
                                try context.save()
                                print("saved")
                                
                                shouldNavigate = true
                            } catch {
                                print("error")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center).foregroundColor(.red)
                    }
                    .scrollContentBackground(.hidden)
                    .background(.orange)
                }
                
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
    
    func delete( indexSet:  IndexSet) {
        for index in indexSet {
            let t = orders[index]
            context.delete(t)
            
            try? context.save()
        }
    }
}
    
#Preview {
    ContentView()
}
