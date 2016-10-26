//
//  MapPersist.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/25/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import MapKit

class MapPersist {
    
    // MARK: - Singleton
    
    /// A shared and threadsafe instance of MapPersist
    static let shared = MapPersist()
    
    private init() {}
   
    // MARK: - Methods
    
    func shouldUseDefaults(zWidth: Double, zHeight: Double) -> Bool {
        return zHeight != 0.0 && zWidth != 0.0
    }
    
    func saveMapParameters(latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoomWidth: CLLocationDistance, zoomHeight: CLLocationDistance) {
        
        NSLog("###### > \nSaving \(latitude) for key \"\(AppConstants.Persist.mapLatitude)\"\nSaving \(longitude) for key \"\(AppConstants.Persist.mapLongitude)\"\nSaving \(zoomWidth) for key \"\(AppConstants.Persist.zoomWidth)\"\nSaving \(zoomHeight) for key \"\(AppConstants.Persist.zoomHeight)\"")
        UserDefaults.standard.set(latitude, forKey: AppConstants.Persist.mapLatitude)
        UserDefaults.standard.set(longitude, forKey: AppConstants.Persist.mapLongitude)
        UserDefaults.standard.set(zoomWidth, forKey: AppConstants.Persist.zoomWidth)
        UserDefaults.standard.set(zoomHeight, forKey: AppConstants.Persist.zoomHeight)
    }
    
    func getMapRegionInfo() -> (width: CLLocationDistance, height: CLLocationDistance) {
        let width = UserDefaults.standard.double(forKey: AppConstants.Persist.zoomWidth)
        let height = UserDefaults.standard.double(forKey: AppConstants.Persist.zoomHeight)
        NSLog("###### > Reading Region out \nWidth of \(width) for key \"\(AppConstants.Persist.zoomWidth)\"\nHeight of \(height) for key \"\(AppConstants.Persist.zoomHeight)\"\n")
        return (width, height)
    }
    
    func getMapLatitude() -> CLLocationDegrees {
        let lat = UserDefaults.standard.double(forKey: AppConstants.Persist.mapLatitude)
        NSLog("###### > Reading Region out \nLatitude of \(lat) for key \"\(AppConstants.Persist.mapLatitude)\"\n")
        return lat
    }
    
    func getMapLongitude() -> CLLocationDegrees {
        let lon = UserDefaults.standard.double(forKey: AppConstants.Persist.mapLongitude)
        NSLog("###### > Reading Region out \nLongitude of \(lon) for key \"\(AppConstants.Persist.mapLongitude)\"\n")
        return lon
    }
}
