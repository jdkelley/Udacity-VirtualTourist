//
//  Pin+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/21/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import CoreData 

extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for images
extension Pin {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: FlickrImage)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: FlickrImage)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
