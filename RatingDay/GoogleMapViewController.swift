//
//  GoogleMapViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/17.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class GoogleMapViewController: UIViewController,CLLocationManagerDelegate {
    
    //data
    var current : Restaurant!
    var placeId : String = ""
    //google setting
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12.0
    var path: GMSMutablePath!

    @IBOutlet var mapView: GMSMapView!
    
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        // 印出目前所在位置座標
        let currentLocation :CLLocation = locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        <#code#>
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
        
        
        
        current = RestaurantDAO.getResByPlaceId(placeId: placeId)!
        let camera = GMSCameraPosition.camera(withLatitude: current.lat, longitude: current.lng, zoom: 12.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: current.lat, longitude: current.lng)
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.title = current.name
        marker.snippet = current.address
        
    }
}
