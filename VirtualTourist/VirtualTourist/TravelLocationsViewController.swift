//
//  TravelLocationsViewController.swift
//  VirtualTourist
//
//  Created by Joshua Kelley on 10/17/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit
import MapKit


class TravelLocationsViewController: UIViewController {
    
    // MARK: - Properties
    
    var isInEditMode: Bool = false

    @IBOutlet weak var mapTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var editModeView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
//    func editTapped(_ sender: AnyObject) {
//        isInEditMode = !isInEditMode
//    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEdit))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // Prepare the destination view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? PhotoAlbumViewController {
            // setup
        }
    }
}

// TODO: - TODOS

extension TravelLocationsViewController {
    
    // Load zoom and center of map
    
    // set zoom and center of map
    
    // check that adding a annotation works
    
    //
    
}

// MARK: MKMapDelegate

extension TravelLocationsViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.Pin) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.Pin)
            pinView!.pinTintColor = .red
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        //
    }
}

// MARK: PushUpEdit

extension TravelLocationsViewController {
    
    func toggleEdit() {
        if isInEditMode {
            UIView.animate(withDuration: 0.1, animations: {
                self.mapTopConstraint.constant += self.editModeView.frame.height
                self.view.layoutIfNeeded()
            }) { (complete) in
                self.isInEditMode = false
            }
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.mapTopConstraint.constant -= self.editModeView.frame.height
                self.view.layoutIfNeeded()
                }) { (complete) in
                    self.isInEditMode = true
                }
        }
    }
}
 
