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
        return zHeight == 0.0 || zWidth == 0.0
    }
    
    func saveMapParameters(latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoomWidth: CLLocationDistance, zoomHeight: CLLocationDistance) {
        UserDefaults.standard.set(latitude, forKey: AppConstants.Persist.mapLatitude)
        UserDefaults.standard.set(longitude, forKey: AppConstants.Persist.mapLongitude)
        UserDefaults.standard.set(zoomWidth, forKey: AppConstants.Persist.zoomWidth)
        UserDefaults.standard.set(zoomHeight, forKey: AppConstants.Persist.zoomHeight)
        
    }
    
    func getMapRegionInfo() -> (width: CLLocationDistance, height: CLLocationDistance) {
        let width = UserDefaults.standard.double(forKey: AppConstants.Persist.zoomWidth)
        let height = UserDefaults.standard.double(forKey: AppConstants.Persist.zoomHeight)
        return (width, height)
    }
    
    func getMapLatitude() -> CLLocationDegrees {
        return UserDefaults.standard.double(forKey: AppConstants.Persist.mapLatitude)
    }
    
    func getMapLongitude() -> CLLocationDegrees {
        return UserDefaults.standard.double(forKey: AppConstants.Persist.mapLongitude)
    }
}
