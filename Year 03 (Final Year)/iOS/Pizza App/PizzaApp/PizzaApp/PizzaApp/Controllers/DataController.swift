//
//  DataController.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Pizzas")
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Failed to load Core Data: \(error.localizedDescription)")
            }
        }
    }
}
