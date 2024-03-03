//
//  MapListItem.swift
//  PetShelter
//
//  Created by Fran Alarza on 26/2/24.
//

import SwiftUI
import MapKit

struct MapListItem: View {
    
    let item: MKMapItem
    var address: String {
        let address = item.placemark
        let addressString = "\(address.thoroughfare ?? "") \(address.subThoroughfare ?? ""), \(address.country ?? ""), \(address.locality ?? "")"
        return addressString
    }
    
    private var distance: Measurement<UnitLength>? {
        guard let userLocation = LocationManager.shared.manager.location,
              let destinationLocation = item.placemark.location else {
            return nil
        }
        
        return calculateDistance(from: userLocation, to: destinationLocation)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name ?? "")
            Text(address)
            if let distance {
                HStack {
                    Text(distance.formatted())
                }
                
            }
        }
    }
}

#Preview {
    MapListItem(item: PreviewData.apple)
}
