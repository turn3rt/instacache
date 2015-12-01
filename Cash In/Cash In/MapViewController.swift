//
//  MapViewController.swift
//  Cash In
//
//  Created by Turner Thornberry on 12/1/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var getCashButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var currentRegion = MKCoordinateRegion()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        self.getCashButton.layer.cornerRadius = 25
        self.getCashButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.getCashButton.layer.shadowOffset = CGSizeMake(2,2)
        self.getCashButton.layer.shadowOpacity = 0.5
        self.getCashButton.layer.shadowRadius = 2

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        currentLocation = center
        currentRegion = region
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    @IBAction func resetLocation(manager: CLLocationManager, didUpdateLocations locations: CLLocation) {
        self.mapView.setRegion(currentRegion, animated: true)
        print("didrun")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
}

