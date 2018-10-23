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

class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet var mapView: GMSMapView!
    //google data
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var path: GMSMutablePath!
    var restaurantData = [Restaurant]()
    var newLocaiton: CLLocationCoordinate2D!
    
    @objc func handleTap(_ sender: UIButton) {
        mapView.camera = GMSCameraPosition(target:newLocaiton , zoom: 16, bearing: 0, viewingAngle: 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let c = locations[0] as CLLocation
        newLocaiton = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude)
        
        mapView.camera = GMSCameraPosition(target: newLocaiton, zoom: 16, bearing: 0, viewingAngle: 0)
            
            restaurantData = RestaurantDAO.getAllRestaurant()!
            for res in restaurantData{
                if abs(newLocaiton.latitude - res.lat) < 1 && abs(newLocaiton.longitude - res.lng) < 1{
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: res.lat, longitude: res.lng)
                    marker.map = mapView
                    marker.snippet = res.address
                    marker.accessibilityLabel = res.placeId
                    
                    var comRating = 0.0
                    if res.googleRating != 0.0{
                        if res.tripRating != 0.0{
                            comRating = (res.googleRating + res.tripRating)/2.0
                        }else{
                            comRating = res.googleRating
                        }
                    }else{
                        if res.tripRating != 0.0{
                            comRating = res.tripRating
                        }
                    }
                    marker.title = "\(res.name)  \(comRating)"
                    
                    if comRating >= 4.5{
                        marker.icon = GMSMarker.markerImage(with: .red)
                    }else if 4 <= comRating && comRating < 4.5 {
                        marker.icon = GMSMarker.markerImage(with: .green)
                    }else if 3 <= comRating && comRating < 4 {
                        marker.icon = GMSMarker.markerImage(with: .blue)
                    }else {
                        marker.icon = GMSMarker.markerImage(with: .lightGray)
                    }
                }
            
        }
    }
    
    //跳轉到ContentViewController,並傳placeId的值
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Page2") as? ContentViewController{
            controller.placeId = marker.accessibilityLabel!
            self.navigationController?.pushViewController(controller, animated: true)
            //present(controller, animated: true, completion: nil)
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
        mapView.delegate = self
        placesClient = GMSPlacesClient.shared()
        mapView.mapType = .normal
        mapView.isMyLocationEnabled = true
        let size = self.view.bounds.size
        print ("[\(size.width),\(size.height)]")
        
        let button = UIButton(frame: CGRect(x: size.width-50, y: size.height-130 ,width: 35, height: 35))
        
        if let image = UIImage(named: "navigation") {
            button.setImage(image, for: .normal)
        }
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        self.view.addSubview(button)
    }
}

