//
//  EventModel.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/5/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import UIKit
class EventModel {
    let key:String!
    let eventRef:FIRDatabaseReference?
    var eventTitle:String!
    let eventMessage:String!
    let eventLocation:String!
    let eventTime:String!
    let eventRestaurant:String!
    let longitude:Double!
    let latitude:Double!
//    let host:String!
    
    
//    let image:UIImage
    
    init(eventTitle:String, eventMessage:String, eventLocation:String, eventTime:String,
         eventRestaurant:String, key:String = "", longitude:Double, latitude:Double) {
        self.eventTitle = eventTitle
        self.eventLocation = eventLocation
        self.eventMessage = eventMessage
        self.eventRestaurant = eventRestaurant
        self.eventTime = eventTime
        self.longitude = longitude
        self.latitude = latitude
//        self.image = image
        eventRef = nil
        self.key = key
        
//        let user = getCurrentUserInfo()
//        self.host = user
    }
    
    func getCurrentUserInfo()->String{
        let user = FIRAuth.auth()?.currentUser
        let currentUser = user?.email
        return currentUser!
    }
    
    func toAnyObject()-> Any{
        
//        var imageData = Data()
//        if UIImagePNGRepresentation(image) != nil{
//            imageData = UIImagePNGRepresentation(image)!
//        }
        
        return ["title":eventTitle,
                "message":eventMessage,
                "location":eventLocation,
                "time":eventTime,
                "restaurant":eventRestaurant,
                "latitude": latitude,
                "longitude":longitude,
//                "image":imageData
                ]
    }
    
    
    init(snapshot:FIRDataSnapshot){
        key = snapshot.key
        eventRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let title = snapshotValue?["title"] as? String{
            eventTitle = title
        }else{
            eventTitle = ""
        }
        
        if let location = snapshotValue?["location"] as? String{
            eventLocation = location
        }else{
            eventLocation = ""
        }
        
        if let restaurant = snapshotValue?["restaurant"] as? String{
            eventRestaurant = restaurant
        }else{
            eventRestaurant = ""
        }
        
        if let time = snapshotValue?["time"] as? String{
            eventTime = time
        }else{
            eventTime = ""
        }
        
        if let message = snapshotValue?["message"] as? String{
            eventMessage = message
        }else{
            eventMessage = "Say Hi~ 👻👻👻"
        }
        
        if let latitudeTemp = snapshotValue?["latitude"] as? String{
            latitude = Double(latitudeTemp)!
        }else{
            latitude = 0.0
        }
        
        if let longitudeTemp = snapshotValue?["longitude"] as? String{
            longitude = Double(longitudeTemp)!
        }else{
            longitude = 0.0
        }
    }
    
}
