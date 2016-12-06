//
//  RestaurantViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/5/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift
import p2_OAuth2
import YelpAPI



class RestaurantViewController: UIViewController {

    let myUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=10883&entity_type=city&radius=1000"
    
    let clientKey = "8ca8132ea2011f2b1b5bcd0822a31984"
    
    typealias JSONStanard = [String:AnyObject]
    
    let zomatoClient = ZomatoClient()
    
    var resModels = [RestaurantMode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData( )
    }
    
    

    func fetchData(){
        
        
        let url = URL(string: myUrl)
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.setValue(clientKey, forHTTPHeaderField: "user-key")
        
        
        Alamofire.request(urlRequest).responseJSON(completionHandler: {
            response in
            
            do{
                var readableData = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! JSONStanard
//                print(readableData)
                if let restaurants = readableData["restaurants"] as? [JSONStanard]{
                    for res in restaurants{
                        let myRes = res["restaurant"] as! JSONStanard
                        print(myRes["name"]!)
                        let resName = myRes["name"] as? String
                        if let locations = myRes["location"] as? JSONStanard{
                            let location = locations["city"] as! String
                            let longitude = locations["longitude"] as! String
                            let latitude = locations["latitude"] as! String
//                            print(location)
                            let resModel = RestaurantMode(restaurantName: resName, location: location, longtitude: longitude, latitude: latitude)
                            self.resModels.append(resModel)
                        }
                    }
                }
                
            }
            catch{
                print(error)
            }
        })
        
    }
}
