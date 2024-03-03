//
//  Hike.swift
//  PetShelter
//
//  Created by Fran Alarza on 22/2/24.
//

import Foundation

struct Hike: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let photo: String
    let miles: Double
}
