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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current = RestaurantDAO.getResByPlaceId(placeId: placeId)!
        let camera = GMSCameraPosition.camera(withLatitude: current.lat, longitude: current.lng, zoom: 16.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: current.lat, longitude: current.lng)
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.title = current.name
        marker.snippet = current.address
        
    }
}
