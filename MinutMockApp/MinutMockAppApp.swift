//
//  MinutMockAppApp.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-15.
//

import SwiftUI
import CoreData

@main
struct MinutMockAppApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some Scene {
        WindowGroup {
            
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.dark)
                
        }
    }
}
