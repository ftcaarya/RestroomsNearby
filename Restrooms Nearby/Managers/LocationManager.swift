//
//  LocationManager.swift
//  Restrooms Nearby
//
//  Created by Aarya Raut on 6/21/24.
//

import Foundation
import MapKit
import Observation

enum LocationError: LocalizedError {
    case authorizationDenied
    case authorizationRestricted
    case unknownLocation
    case accessDenied
    case network
    case operationFailed
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return NSLocalizedString("Location access denied", comment: "")
            
        case .authorizationRestricted:
            return NSLocalizedString("Location access restriction", comment: "")
            
        case .unknownLocation:
            return NSLocalizedString("Location Unknown", comment: "")
            
        case .accessDenied:
            return NSLocalizedString("Access Denied", comment: "")
            
        case .network:
            return NSLocalizedString("Network Failed", comment: "")
        
        case .operationFailed:
            return NSLocalizedString("Operation Failed", comment: "")
        }
    }
}

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    static let shared = LocationManager()
    var error: LocationError? = nil
    
    var region: MKCoordinateRegion?
    
    private override init () {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.delegate = self
    }
}


extension LocationManager {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        }
    }
    
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                self.error = .unknownLocation
            
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
