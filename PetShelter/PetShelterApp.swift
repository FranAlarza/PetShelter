//
//  PetShelterApp.swift
//  PetShelter
//
//  Created by Fran Alarza on 22/2/24.
//

import SwiftUI

@main
struct PetShelterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MapView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
