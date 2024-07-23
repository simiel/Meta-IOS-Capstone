//
//  Meta_IOS_CapstoneApp.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

@main
struct Meta_IOS_CapstoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
