//
//  PizzaAppApp.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import SwiftUI

@main
struct PizzaAppApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
