//
//  MinutMockAppApp.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-15.
//

import SwiftUI

@main
struct MinutMockAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
