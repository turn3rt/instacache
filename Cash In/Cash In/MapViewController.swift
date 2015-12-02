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
    
    @IBOutlet weak var resetMapButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    let locationManager = CLLocationManager()
    var currentRegion = MKCoordinateRegion()
    var currentCenter = CLLocationCoordinate2D()

    var localAPI = LocalAPI()
    
    //TODO: Put live data
    let vendorLocation = CLLocationCoordinate2D(latitude: 25.8246631622314, longitude: -80.1212844848633)
    let testLocation = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        //request map directions from current loc
        let request = MKDirectionsRequest()
        let finalDestination = MKMapItem(placemark: MKPlacemark(coordinate: testLocation, addressDictionary: nil))
        request.source = MKMapItem.mapItemForCurrentLocation() //for demo need to swap this val to be the vendor location
        request.destination = finalDestination
        request.requestsAlternateRoutes = false
        request.transportType = .Automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
        localAPI.checkAFNetworking()

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
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }
    
    
   // have no idea why this function isn't running or working
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        

        if !(annotation is MKPointAnnotation || annotation is VendorPin) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("demo")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        //TODO: resize this image
        annotationView!.image = Helper.ResizeImage(UIImage(named: "Money@2x.png")!, targetSize: CGSizeMake(25, 25))
        return annotationView
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //current users location:
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        currentRegion = region
        currentCenter = center
        self.mapView.setRegion(region, animated: true)
        
        //static vendor location
        let vendorPin = VendorPin(coordinate: vendorLocation, title: "Cash is here", subtitle: "It's on the way!")
        mapView.addAnnotation(vendorPin)
        
        
        
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

