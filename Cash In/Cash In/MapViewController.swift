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
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    let locationManager = CLLocationManager()
    var currentRegion = MKCoordinateRegion()

    var vendor: Vendor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        

        vendor = Vendor()
        vendor!.checkAFNetworking()

        self.resetMapButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.resetMapButton.layer.shadowOffset = CGSizeMake(2,2)
        self.resetMapButton.layer.shadowOpacity = 0.5
        self.resetMapButton.layer.shadowRadius = 2
        
        
//        //if not online, show profile page
//        if (true) {
//            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
//            self.showViewController(vc, sender: self)
//        }


    }
    
    
    //have no idea why this function isn't running or working
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        
//
//        if !(annotation is MKPointAnnotation || annotation is VendorPin) {
//            return nil
//        }
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("demo")
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
//            annotationView!.canShowCallout = true
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//        
//        //TODO: resize this image
//        annotationView!.image = UIImage(named: "money.png")
//        return annotationView
//        
//    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //current users location:
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        currentRegion = region
        self.mapView.setRegion(region, animated: true)
        
        //static vendor location
        let vendorLocation = CLLocationCoordinate2D(latitude: 25.8246631622314, longitude: -80.1212844848633)
        let vendorPin = VendorPin(coordinate: vendorLocation, title: "Cash is here", subtitle: "It's on the way!")
        mapView.addAnnotation(vendorPin)
        
        
        
        self.locationManager.stopUpdatingLocation()
    }
    
    @IBAction func showCashSelectSheet(sender: UIButton) {
        let cashMenu = UIAlertController(title: nil, message: "Select The Desired Cash Amount", preferredStyle: .ActionSheet)
        let alertPopUp = UIAlertController(title: "Something Happened", message: "Click Below", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Yes", style: .Default, handler: nil)
        
        
        let twentyDollars = UIAlertAction(title: "$20", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
            print("20 Selected")
        })
        let fourtyDollars = UIAlertAction(title: "$40", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
            print("40 Selected")
        })
        let sixtyDollars = UIAlertAction(title: "$60", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
            print("60 Selected")
        })
        let eightyDollars = UIAlertAction(title: "$80", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
            print("80 Selected")
        })
        let lotsOfDollars = UIAlertAction(title: "$100", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentViewController(alertPopUp, animated: true, completion: nil)
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

