//
//  FlickrImage+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/21/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import CoreData

extension FlickrImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlickrImage> {
        return NSFetchRequest<FlickrImage>(entityName: "FlickrImage");
    }

    @NSManaged public var url: String?
    @NSManaged public var image: NSData?
    @NSManaged public var downloaded: Bool
    @NSManaged public var pin: Pin?

}
