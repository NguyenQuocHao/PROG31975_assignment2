//
//  ListView.swift
//  MyOrderHao
//
//  Created by user275773 on 10/10/25.
//

import SwiftUI

struct ListView: View {
    @Binding var list: [Order]
    var body: some View {
        VStack {
            Text("Total: \(list.count)")
            
            ForEach(list, id : \.self){ item in
                Text("Order: \(item.size)")
            }
        }
    }
}
