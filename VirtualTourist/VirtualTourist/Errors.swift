//
//  Errors.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/24/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation

struct ImageDownloadError: Error {
    
    enum ErrorKind {
        case  invalidUrlString
        case  downloadOfDataFailed
        case  imageDataFailedToConvertToImage
    }
    
    let kind: ErrorKind
    let message : String
    
}

struct GetRequestError: Error {
    
    enum ErrorKind {
        case non200Response
        case errorInResponse
        case noData
    }
    
    let kind: ErrorKind
    let message: String
    let url: String
    let errorMessage: String
    
}

struct URLRequestParseToJSONError: Error {
    enum ErrorKind {
        case unparsableToJSON
    }
    let kind: ErrorKind
    let message: String
    let data: Data
}

struct FlickrDeserializationError: Error {
    enum ErrorKind {
        case resultNotDictionary
        case photosResultObjectNotResolvable
        case photoDictionaryDoesNotExist
        case urlDoesNotExist
    }
    let kind: ErrorKind
    let message: String
    let data: Any
    
    var userFriendlyDisplay: String {
        switch self.kind {
        case .resultNotDictionary:
            return "Response Object from Flickr could not be cast as a Dictionary."
        case .photosResultObjectNotResolvable:
            return "Expected photos object on Flickr response does not exist."
        case .photoDictionaryDoesNotExist:
            return "Dictionary of photo objects does not exist."
        case .urlDoesNotExist:
            return "URL on photo object does not exist."
        }
    }
}

