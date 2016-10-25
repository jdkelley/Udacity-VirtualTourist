//
//  MapPersist.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/25/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation


class MapPersist {
    
    // MARK: - Singleton
    
    /// A shared and threadsafe instance of MapPersist
    static let shared = MapPersist()
    
    private init() {}
   
    // MARK: - Methods
    
    func saveMapParameters(latitude: Double, longitude: Double, zoom: Double) {
        UserDefaults.standard.set(latitude, forKey: AppConstants.Persist.mapLatitude)
        UserDefaults.standard.set(longitude, forKey: AppConstants.Persist.mapLongitude)
        UserDefaults.standard.set(zoom, forKey: AppConstants.Persist.mapZoomLevel)
    }
    
    func getMapZoom() -> Double {
        return UserDefaults.standard.double(forKey: AppConstants.Persist.mapZoomLevel)
    }
    
    func getMapLatitude() -> Double {
        return UserDefaults.standard.double(forKey: AppConstants.Persist.mapLatitude)
    }
    
    func getMapLongitude() -> Double {
        return UserDefaults.standard.double(forKey: AppConstants.Persist.mapLongitude)
    }
}
