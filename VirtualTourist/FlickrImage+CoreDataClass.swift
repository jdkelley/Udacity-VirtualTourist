//
//  FlickrImage+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/21/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import CoreData


public class FlickrImage: NSManagedObject {
    
    static let name = "FlickrImage"
    
    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: Pin.name, in: context) {
            self.init(entity: ent, insertInto: context)
//            self.latitude = latitude
//            self.longitude = longitude
            
        } else {
            fatalError(AppConstants.ErrorMessages.UnableToFindEntityName)
        }
    }

}
