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
    var placesClient: GMSPlacesClient!
    var path: GMSMutablePath!
    var restaurantData = [Restaurant]()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let c = locations[0] as CLLocation
        let newLocaiton = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude)
        if let location = locations.first {
            CATransaction.begin()
            CATransaction.setValue(Int(2), forKey: kCATransactionAnimationDuration)
            mapView.animate(toLocation: location.coordinate)
            mapView.animate(toZoom: 16)
            CATransaction.commit()
            
            restaurantData = RestaurantDAO.getAllRestaurant()!
            for res in restaurantData{
                if abs(newLocaiton.latitude - res.lat) < 1 && abs(newLocaiton.longitude - res.lng) < 1{
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: res.lat, longitude: res.lng)
                    marker.map = mapView
                    marker.icon = GMSMarker.markerImage(with: .blue)
                    marker.title = res.name
                    marker.snippet = res.address
                    
                    
                }
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
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
        mapView.isMyLocationEnabled = true
        
        
       
    }

}
