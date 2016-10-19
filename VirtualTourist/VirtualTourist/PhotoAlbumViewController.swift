//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/17/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit
import MapKit

class PhotoAlbumViewController: UIViewController {
    
    // MARK: Properties
    
    var location: CLLocation?
    var annotation: MKAnnotation?
    
    // MARK: Outlets
    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Actions
    
    
    /// New Collection Action.
    /// 
    /// This method goes out and get a new collection of Flickr images for this coordinate set. 
    /// This is only possible (the button is only enabled) once the last download has finished.
    ///
    /// - parameter sender: The `UIButton` sending the action.
    @IBAction func newCollectionTapped(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(leavePage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    func leavePage() {
        print("OK Tapped")
    }
    
    
}

extension PhotoAlbumViewController : UICollectionViewDelegate {
    
}
