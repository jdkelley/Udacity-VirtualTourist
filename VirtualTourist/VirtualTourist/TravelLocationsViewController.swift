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
    var annotation: MKPointAnnotation?

    @IBOutlet weak var mapTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var editModeView: UIView!
    @IBOutlet weak var mapView: MKMapView! { didSet { mapView.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mapview
        
        let gr = UILongPressGestureRecognizer(target: self, action: #selector(addPinForPress(_:)))
        gr.minimumPressDuration = 0.3
        mapView.addGestureRecognizer(gr)
        
        // Navigation
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
            guard let annotation = self.annotation else {
                return
            }
            vc.annotation = annotation
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

// MARK: - Add Pin For Long Press

extension TravelLocationsViewController {
    
    func addPinForPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        print("Add Pin For Press")
        
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            // TODO: - Persist and start download
        }
    }
    
}


//
//extension MKPointAnnotation {
//    convenience init(pin: Pin) {
//        self.init()
//        self.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
//    }
//    
//    static func from(pins: [Pin]) -> [MKPointAnnotation] {
//        var annotations: [MKPointAnnotation] = []
//        for pin in pins {
//            annotations.append(MKPointAnnotation(pin: pin))
//        }
//        return
//    }
//}

// MARK: MKMapDelegate

extension TravelLocationsViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: AppConstants.Pin) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: AppConstants.Pin)
            pinView!.pinTintColor = .red
            pinView!.sizeThatFits(CGSize(width: 30, height: 100))
            pinView!.animatesDrop = true
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }
        
        if isInEditMode {
            mapView.removeAnnotation(annotation)
        } else {
            self.annotation = annotation
            self.performSegue(withIdentifier: AppConstants.Segue, sender: annotation)
        }
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
 
