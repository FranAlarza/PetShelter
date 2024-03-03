//
//  MapOptions.swift
//  PetShelter
//
//  Created by Fran Alarza on 24/2/24.
//

import Foundation
import _MapKit_SwiftUI

enum MapOptions: String, Identifiable, CaseIterable {
    
    case standard
    case hybrid
    case imagery
    
    var id: String {
        return self.rawValue
    }
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}
