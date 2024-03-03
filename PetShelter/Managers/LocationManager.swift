//
//  LocationManager.swift
//  PetShelter
//
//  Created by Fran Alarza on 25/2/24.
//

import Foundation
import MapKit
import Observation

enum LocationError: LocalizedError {
    case authorizationDenied
    case authorizationRestricted
    case unknowLocation
    case accessDenied
    case network
    case operationFailed
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return NSLocalizedString("Location Access Denied.", comment: "")
        case .authorizationRestricted:
            return NSLocalizedString("Location Access Restricted.", comment: "")
        case .unknowLocation:
            return NSLocalizedString("Unknown location.", comment: "")
        case .accessDenied:
            return NSLocalizedString("Access Denied.", comment: "")
        case .network:
            return NSLocalizedString("Networl Failed.", comment: "")
        case .operationFailed:
            return NSLocalizedString("Operation failed.", comment: "")
        }
    }
}

@Observable
final class LocationManager: NSObject {
    static let shared = LocationManager()
    let manager: CLLocationManager = CLLocationManager()
    var region: MKCoordinateRegion = MKCoordinateRegion()
    var error: LocationError?
    
    override init() {
        super.init()
        self.manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            error = .authorizationDenied
        case .restricted:
            error = .authorizationRestricted
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: .init(
                    latitude: $0.coordinate.latitude,
                    longitude: $0.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                self.error = .unknowLocation
            case .denied:
                self.error = .accessDenied
            case .network:
                self.error = .network
            default:
                self.error = .operationFailed
            }
        }
    }
}
