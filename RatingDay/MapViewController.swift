//
//  MapViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/18.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet var mapView: GMSMapView!
    //google data
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12.0
    var path: GMSMutablePath!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let c = locations[0] as CLLocation
        let newLocaiton = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude)
        if let location = locations.first {
            CATransaction.begin()
            CATransaction.setValue(Int(2), forKey: kCATransactionAnimationDuration)
            mapView.animate(toLocation: location.coordinate)
            mapView.animate(toZoom: 12)
            CATransaction.commit()
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init LocationManager
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()

        mapView.mapType = .normal
        //let defaultCenter = CLLocationCoordinate2D(latitude: -32.725757, longitude: 21.481987)
        //mapView.camera = GMSCameraPosition(target: defaultCenter, zoom: 1, bearing: 0, viewingAngle: 0)
        mapView.isMyLocationEnabled = true
        
        
       
    }

}
