//
//  EventModel.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/5/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit
class EventModel {
    let key:String!
    let eventRef:FIRDatabaseReference?
    let eventTitle:String!
    let eventMessage:String!
    let eventLocation:String!
    let eventTime:String!
    let eventRestaurant:String!
    let longitude:Double!
    let latitude:Double!
    let image:UIImage
    
    init(eventTitle:String, eventMessage:String, eventLocation:String, eventTime:String,
         eventRestaurant:String, key:String = "", longitude:Double, latitude:Double, image:UIImage) {
        self.eventTitle = eventTitle
        self.eventLocation = eventLocation
        self.eventMessage = eventMessage
        self.eventRestaurant = eventRestaurant
        self.eventTime = eventTime
        self.longitude = longitude
        self.latitude = latitude
        self.image = image
        eventRef = nil
        self.key = key
    }
    
    func toAnyObject()-> Any{
        
        var imageData = Data()
        if UIImagePNGRepresentation(image) != nil{
            imageData = UIImagePNGRepresentation(image)!
        }
        
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
    
    
//    init(snapshot:FIRDataSnapshot){
//        eventTitle = snapshot.key
//        eventRef = snapshot.ref
//        
//        if let title = snapshot.value as? String{
//            eventTitle = title
//        }else{
//            eventTitle = ""
//        }
//        
//        if let message = snapshot.v
//    }
    
}
