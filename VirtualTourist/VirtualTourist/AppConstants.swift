//
//  AppContstants.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/17/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation

class AppConstants {
    
    /// Pin Reuse Identifier
    static let Pin : String = "Pin"
    
    /// Segue identifier
    static let Segue : String = "ShowAlbumForPin"
    
    /// Magic string identifier for `TravelLocationsViewController.`
    static let TravelLocationsViewController : String = "TravelLocationsViewController"
    
    /// Magic string identifier for `TravelLocationsViewController.`
    static let PhotoAlbumViewController : String = "PhotoAlbumViewController"
    
    struct ErrorMessages {
        static let UnableToFindEntityName = "Unable To Find Entity Name!"
    }
    
    struct Persist {
        
        static let HasLaunchedBefore = "hasLaunchedBefore"
        
        static let mapLatitude = "mapLatitude"
        
        static let mapLongitude = "mapLongitude"
        
        static let zoomWidth = "zoomWidth"
        
        static let zoomHeight = "zoomHeight"
        
    }
}
