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
    @IBOutlet weak var resetMapButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    

    let locationManager = CLLocationManager()
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
        self.getCashButton.layer.shadowOpacity = 0.8
        self.getCashButton.layer.shadowRadius = 2
        
        self.resetMapButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.resetMapButton.layer.shadowOffset = CGSizeMake(2,2)
        self.resetMapButton.layer.shadowOpacity = 0.5
        self.resetMapButton.layer.shadowRadius = 2

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        currentRegion = region
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    @IBAction func showCashSelectSheet(sender: UIButton) {
        let cashMenu = UIAlertController(title: nil, message: "Select The Desired Cash Amount", preferredStyle: .ActionSheet)
        let alertPopUp = UIAlertController(title: "Something Happened", message: "Nafis Sux Penis", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Yes I do", style: .Default, handler: nil)
        
        
        let twentyDollars = UIAlertAction(title: "$20", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
            print("20 Selected")
        })
        let fourtyDollars = UIAlertAction(title: "$40", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("40 Selected")
        })
        let sixtyDollars = UIAlertAction(title: "$60", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("60 Selected")
        })
        let eightyDollars = UIAlertAction(title: "$80", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("80 Selected")
        })
        let lotsOfDollars = UIAlertAction(title: "$100", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("100 Selected")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        cashMenu.addAction(twentyDollars)
        cashMenu.addAction(fourtyDollars)
        cashMenu.addAction(sixtyDollars)
        cashMenu.addAction(eightyDollars)
        cashMenu.addAction(lotsOfDollars)
        cashMenu.addAction(cancel)
        
        alertPopUp.addAction(action)
        
        
        self.presentViewController(cashMenu, animated: true, completion: nil)
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

