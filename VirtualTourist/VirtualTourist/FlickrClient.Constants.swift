//
//  FlickrClient.Constants.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/24/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation

extension FlickrClient {

    /// Constants relating to the FlickrClient Networking calls
    ///
    ///
    /// Constants include:
    ///  * `apiScheme` = "https"
    ///  * `apiHost` = "api.flickr.com"
    ///  * `apiPath` = "/services/rest"
    ///  * `searchBBoxHalfWidth` = 1.0
    ///  * `searchBBoxHalfHeight` = 1.0
    ///  * `searchLatRange` = (-90.0, 90.0)
    ///  * `SearchLonRange` = (-180.0, 180.0)
    struct Constants {
        
        ///"https"
        static let apiScheme = "https"
        
        /// "api.flickr.com"
        static let apiHost = "api.flickr.com"
        
        /// "/services/rest"
        static let apiPath = "/services/rest"

        /// Double: 1.0
        static let searchBBoxHalfWidth = 1.0
        
        /// Double: 1.0
        static let searchBBoxHalfHeight = 1.0
        
        /// Tuple: (-90.0, 90.0)
        static let searchLatRange = (-90.0, 90.0)
        
        /// Tuple: (-180.0, 180.0)
        static let searchLonRange = (-180.0, 180.0)
    }
    
    /// Constants that define url parameter keys.
    ///
    /// These keys include:
    ///  * `method` = "method"
    ///  * `apiKey` = "api_key"
    ///  * `bbox` = "bbox"
    ///  * `safeSearch` = "safe_search"
    ///  * `lat` = "lat"
    ///  * `lon` = "lon"
    ///  * `extras` = "extras"
    ///  * `format` = "format"
    ///  * `nojsoncallback` = "nojsoncallback"
    struct ParameterKeys {
        
        /// "method"
        static let method = "method"
        
        /// "api_key"
        static let apiKey = "api_key"
        
        /// "bbox"
        static let bbox = "bbox"
        
        /// "safe_search"
        static let safeSearch = "safe_search"
        
        /// "lat"
        static let lat = "lat"
        
        /// "lon"
        static let lon = "lon"
        
        /// "extras"
        static let extras = "extras"
        
        /// "format"
        static let format = "format"
        
        /// "nojsoncallback"
        static let nojsoncallback = "nojsoncallback"
    }
    
    /// Constants used as values in the url parameters
    /// The API Key can be found at `Constants.FlickrAPIKey`
    ///
    /// These values include :
    ///  * `searchMethod` = "flickr.photos.search"
    ///  * `safeSearch` = 1
    ///  * `extras` = "url_m"
    ///  * `format` = "json"
    ///  * `nojsoncallback` = 1
    struct ParameterValues {
        
        /// "flickr.photos.search"
        static let searchMethod = "flickr.photos.search"
        
        /// Integer: 1
        static let safeSearch = 1
        
        /// "url_m"
        static let extras = "url_m"
        
        /// "json"
        static let format = "json"
        
        /// Integer: 1
        static let nojsoncallback = 1
    }
    
    /// Constants used to access values in the response object
    struct ResponseKeys {
        
        /// The response object key to a image search using the method "flickr.photos.search"
        /// Value: "photos"
        static let photos = "photos"
        
        /// The total number of pictures matching the search
        /// Value: "total"
        static let total = "total"
        
        /// The key to the array of photo objects in the Flickr Response
        /// Value: "photo"
        static let photo = "photo"
        
        // In each photo object:
        
        /// The url defining the resulting image
        /// Value: "url_m"
        static let url_m = "url_m"
    }
}
