// Code by Hao Nguyen, 991521091

import SwiftUI
import SwiftData

@main
struct MyOrderHaoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for : Order.self)
    }
}

