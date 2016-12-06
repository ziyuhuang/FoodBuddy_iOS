//
//  RestaurantModel.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/6/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import Foundation
class RestaurantMode: NSObject {
    var restaurantName:String!
    var location:String!
    var longtitude:String!
    var latitude:String!
//    var restaurantID:Int!
    
    
    required init(restaurantName:String!, location:String!, longtitude:String!, latitude:String!){
        self.restaurantName = restaurantName
//        self.restaurantID = restaurantID
        self.location = location
        self.longtitude = longtitude
        self.latitude = latitude
    }
}
