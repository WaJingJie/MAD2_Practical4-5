//
//  MapViewController.swift
//  Telegramme
//
//  Created by MAD2 on 7/1/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController{
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    let regionRadius: CLLocationDistance = 250
    
    
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = locationDelegate
        
        locationManager.requestWhenInUseAuthorization()
        
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
            /*let lat = String(format: "Lat: %3.8f", location.coordinate.latitude)
            let long = String(format: "Long: %3.8f", location.coordinate.longitude)
            
            print("\(lat),\(long)")*/
            
            self.MapView.showsUserLocation = true
            self.centerMapOnLocation(location: location)
            
        }
    
    }
    
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion (
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        
        MapView.setRegion(coordinateRegion, animated: true)
        let selfAnnotation = MKPointAnnotation()
        selfAnnotation.coordinate = location.coordinate
        selfAnnotation.title = "Me"
        selfAnnotation.subtitle = "Me"
        self.MapView.addAnnotation(selfAnnotation)
        
        //GeoCode
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(
            "535 Clementi Road Singapore 599489",
            completionHandler: {p,e in
            let lat = String(format: "Lat: %3.12f", p![0].location!.coordinate.latitude)
            let long = String(format: "Long: %3.12f", p![0].location!.coordinate.longitude)
            
                let annotation = MKPointAnnotation()

                annotation.coordinate = p![0].location!.coordinate
                annotation.title = "Ngee Ann Polytechnic"
                annotation.subtitle = "School of ICT"
                self.MapView.addAnnotation(annotation)

        print("\(lat), \(long)")
        })
    }
}
    

