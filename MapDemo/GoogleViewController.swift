//
//  ViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/3/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleViewController: UIViewController {
    
    var latitude = Double()
    var longitude = Double()
    var restaurant = String()
    
    var mapView: GMSMapView?
//    var marker:GMSMarker?

    
    override func viewDidLoad(){
        print(latitude)
        print(longitude)
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyBRLTH01_cVHGWz7kOPieKgDgpyGteZyN4");
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position:currentLocation)
        marker.title = restaurant
        marker.snippet = "food"
        marker.map = mapView
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"next",
//                                                            style: UIBarButtonItemStyle.plain,
//                                                            target: self,
//                                                            action:#selector(ViewController.next as (ViewController) -> () -> ()))
    
        
    }
    
    func next(){
        let nextLocation = CLLocationCoordinate2DMake(37.287905, -121.830675)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 12)
        let marker = GMSMarker(position: nextLocation)
        marker.title = "Home"
        marker.map = mapView
    }

    
  	

}



