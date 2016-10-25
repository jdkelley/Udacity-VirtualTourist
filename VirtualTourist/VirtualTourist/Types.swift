//
//  Types.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/24/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import UIKit

typealias DownloadedImageHandler = (UIImage?, Error?) -> Void

extension FlickrClient {
    typealias CompletionHandlerForGet = (Any?, Error?) -> Void
    typealias DataLayerUIAlert = (Bool, String) -> Void
}

