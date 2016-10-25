//
//  FlickrClient.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/19/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import Foundation
import UIKit

class FlickrClient {
    
    // MARK: - Singleton
    
    /// A shared and threadsafe instance of FlickrClient
    static let sharedInstance = FlickrClient()
    
    private init() {}
    
    // MARK: Search By Location
    
    func imageSearchByLocation() {
        // get lat and long
        let lat = 36.2
        let lon = 81.7
        
        // get urls
        taskForGet(latitude: lat, longitude: lon) { (data, error) in
            if let error = error {
                if error is ImageDownloadError {
                    
                } else if error is GetRequestError {
                    
                } else if error is URLRequestParseToJSONError {
                    
                }
            } else {
                guard let result = data as? [String: Any] else {
                    let notDictionary = FlickrDeserializationError(kind: .resultNotDictionary, message: "Results could not be cast as the expected JSON object.", data: data)
                    return
                }
                
                guard let photosObject = result[ResponseKeys.photos] as? [String: Any] else {
                    let noPhotosResult = FlickrDeserializationError(kind: .photosResultObjectNotResolvable, message: "Photos Object Does Not Exist.", data: result)
                    return
                }
                
                guard let photoArray = photosObject[ResponseKeys.photo] as? [[String: Any]] else {
                    let photoObjectArrayDNE = FlickrDeserializationError(kind: .photoDictionaryDoesNotExist, message: "Dictionary of photo objects does not exist.", data: photosObject)
                    return
                }
                
                let array: [String] = photoArray.flatMap {
                    guard let urlString = $0[FlickrClient.ResponseKeys.url_m] as? String else {
                        return nil
                    }
                    return urlString
                }
             
                // Do something with the array of urls
                
                
            }
        }
    }
    
    // MARK: Task For GET
    
    func taskForGet(latitude: Double, longitude: Double, completionHandlerForGet: @escaping CompletionHandlerForGet) -> URLSessionDataTask {
        let url = flickrUrl(latitude: latitude, longitude: longitude)
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                let getError = GetRequestError(kind: .errorInResponse, message: "There was an error with your request.", url: url.absoluteString, errorMessage: "\(error!)")
                completionHandlerForGet(nil, getError)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode < 300 else {
                let getError = GetRequestError(kind: .non200Response, message: "Request returned something other than a 2xx response.", url: url.absoluteString, errorMessage: "")
                completionHandlerForGet(nil, getError)
                return
            }
            
            guard let unwrappedData = data else {
                let getError = GetRequestError(kind: .noData, message: "No Data was returned from your request!", url: url.absoluteString, errorMessage: "")
                completionHandlerForGet(nil, getError)
                return
            }
            self.convert(data: unwrappedData, with: completionHandlerForGet)
        }
        task.resume()
        return task
    }
    
    func convert(data: Data, with: CompletionHandlerForGet) {
        var parsedResult: Any!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            let deserializeError = URLRequestParseToJSONError(kind: .unparsableToJSON, message: "Could not parse the data as JSON.", data: data)
            with(nil, deserializeError)
            return
        }
        with(parsedResult, nil)
    }
    

    
    func fetchImageFor(url: URL,  completion: @escaping DownloadedImageHandler) {
        
    }
}

// MARK: - Convenience

extension FlickrClient {
    
    
    /// Builds a URL to request a latitude/longitude search from Flickr.
    ///
    /// - parameter latitude:  The latitude to search at.
    /// - parameter longitude: The longitude to search at.
    ///
    /// - returns: A valid URL.
    fileprivate func flickrUrl(latitude: Double, longitude: Double) -> URL {
        let parameters: [String: Any] = [
            ParameterKeys.method            : ParameterValues.searchMethod,
            ParameterKeys.apiKey            : AppConstants.FlickrAPIKey,
            ParameterKeys.safeSearch        : ParameterValues.safeSearch,
            ParameterKeys.extras            : ParameterValues.extras,
            ParameterKeys.format            : ParameterValues.format,
            ParameterKeys.nojsoncallback    : ParameterValues.nojsoncallback,
            ParameterKeys.bbox              : bboxString(latitude: latitude, longitude: longitude),
            ParameterKeys.lat               : latitude,
            ParameterKeys.lon               : longitude
        ]
        
        return flickrUrlFrom(parameters: parameters)
    }
    
    
    /// Builds a valid `URL` instance from query parameters and url components.
    ///
    /// - parameter parameters: This is a `[String: Any]` dictionary that holds the key-value pairs that will be `URLQueryItems`.
    ///
    /// - returns: A valid URL.
    fileprivate func flickrUrlFrom(parameters: [String: Any]) -> URL {
        var components = URLComponents()
        components.scheme = Constants.apiScheme
        components.host = Constants.apiHost
        components.path = Constants.apiPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    
    /// `bboxString` creates a url-safe bounding box parameter.
    ///
    /// - parameter latitude:  The center coordinate's latitude of the bounding box
    /// - parameter longitude: The center coordinate's longitude of the bounding box
    ///
    /// - returns: A string describing the bounding box ready to be passed as a url parameter.
    fileprivate func bboxString(latitude: Double, longitude: Double) -> String {
        let minLon = max(longitude - Constants.searchBBoxHalfWidth, Constants.searchLonRange.0)
        let minLat = max(latitude - Constants.searchBBoxHalfHeight,Constants.searchLatRange.0)
        let maxLon = min(longitude + Constants.searchBBoxHalfWidth,Constants.searchLonRange.1)
        let maxLat = min(latitude + Constants.searchBBoxHalfHeight, Constants.searchLatRange.1)
        return "\(minLon),\(minLat),\(maxLon),\(maxLat)"
    }

}
