//
//  MKMapView+Helpers.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/25/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func setZoomFor(annotation: MKPointAnnotation, widthInMeters: CLLocationDistance = 4500.0, heightInMeters: CLLocationDistance = 1500.0) {
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(annotation.coordinate, heightInMeters, widthInMeters)
        let adjustedRegion = self.regionThatFits(viewRegion)
        self.setRegion(adjustedRegion, animated: true)
    }
    
    func getZoomLevel() -> (lonWidth: CLLocationDistance, latHeight: CLLocationDistance) {
        let heightInMeters = self.region.span.latitudeDelta
        let widthInMeters = self.region.span.longitudeDelta
        return (widthInMeters, heightInMeters)
    }
}
