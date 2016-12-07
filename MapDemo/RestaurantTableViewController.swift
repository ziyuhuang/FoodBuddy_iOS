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
//
//struct RestaurantCell{
//    var restaurantImageView: UIImageView!
//    var restaurantName: UILabel!
//    var restaurantAddress: UILabel!
//}

class RestaurantTableViewController: UITableViewController{
    
    let myUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=10883&entity_type=city&radius=1000"
    
    let clientKey = "8ca8132ea2011f2b1b5bcd0822a31984"
    
    typealias JSONStanard = [String:AnyObject]
    
    let zomatoClient = ZomatoClient()
    
    var resModels = [RestaurantMode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData( )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resModels.count
    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let restaurantImageView = cell.viewWithTag(1) as! UIImageView
        let restaurantName = cell.viewWithTag(2) as! UILabel
        let restaurantAddress = cell.viewWithTag(3) as! UILabel
        let createBtn = cell.viewWithTag(4) as! UIButton
        
        restaurantImageView.image = resModels[indexPath.row].image
        restaurantName.text = resModels[indexPath.row].restaurantName
        restaurantAddress.text = resModels[indexPath.row].location
        return cell
    }
//
//    
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
                        
                        var location = String()
                        var longitude = String()
                        var latitude = String()
                        var image = UIImage()
                        
                        if let locations = myRes["location"] as? JSONStanard{
                            location = locations["city"] as! String
                            longitude = locations["longitude"] as! String
                            latitude = locations["latitude"] as! String
                            //                            print(location)
                        }
                        
                        //get image
                        let featuredImageUrl = myRes["featured_image"] as! String
                        let imageUrl = NSURL(string: featuredImageUrl) as! URL
                        if let imageData = NSData(contentsOf: imageUrl) as? Data{
                            image = UIImage(data: imageData)!
                        }
                        
                        let resModel = RestaurantMode(restaurantName: resName, location: location, longtitude: longitude, latitude: latitude, image:image)
                        self.resModels.append(resModel)
                        self.tableView.reloadData()
                        
                    }
                }
                
            }
            catch{
                print(error)
            }
        })
        
    }
}
