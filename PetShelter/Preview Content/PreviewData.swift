//
//  PreviewData.swift
//  PetShelter
//
//  Created by Fran Alarza on 28/2/24.
//

import Foundation
import MapKit
import Contacts

struct PreviewData {
    
    static var apple: MKMapItem {
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.33477647201317,  longitude: -122.00865878226745)
        
        let addressDictionary: [String: Any] = [
            CNPostalAddressCityKey: "1 Infinite Loop",
            CNPostalAddressCityKey: "Cupertino",
            CNPostalAddressStateKey: "CA",
            CNPostalAddressPostalCodeKey: "95014",
            CNPostalAddressCountryKey: "United States"
        ]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Apple Inc."
        
        return mapItem
    }
}
