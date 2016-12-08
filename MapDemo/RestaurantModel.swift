//
//  RestaurantModel.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/6/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import Foundation
import UIKit
class RestaurantMode: NSObject {
    var restaurantName:String!
    var location:String!
    var longitude:Double!
    var latitude:Double!
    var image:UIImage?
//    var restaurantID:Int!
    
    
    required init(restaurantName:String!, location:String!, longtitude:Double!, latitude:Double!, image:UIImage?){
        self.restaurantName = restaurantName
        self.image = image
        self.location = location
        self.longitude = longtitude
        self.latitude = latitude
    }
}
