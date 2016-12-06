//
//  ViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/3/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
//    var marker:GMSMarker?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyBRLTH01_cVHGWz7kOPieKgDgpyGteZyN4");
        let camera = GMSCameraPosition.camera(withLatitude: 37.335170, longitude: -121.881104, zoom: 12)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.335520, -121.885020)
        let marker = GMSMarker(position:currentLocation)
        marker.title = "San Jose State University"
        marker.snippet = "SJSU"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"next",
                                                            style: UIBarButtonItemStyle.plain,
                                                            target: self,
                                                            action:#selector(ViewController.next as (ViewController) -> () -> ()))
    
        
    }
    
    func next(){
        let nextLocation = CLLocationCoordinate2DMake(37.287905, -121.830675)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 12)
        let marker = GMSMarker(position: nextLocation)
        marker.title = "Home"
        marker.map = mapView
    }

    
  	

}



