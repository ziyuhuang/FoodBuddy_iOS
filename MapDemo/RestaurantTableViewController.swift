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
//
//struct RestaurantCell{
//    var restaurantImageView: UIImageView!
//    var restaurantName: UILabel!
//    var restaurantAddress: UILabel!
//}

class RestaurantTableViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationID:Int?
    
    var myUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=278&entity_type=city&radius=1000"
//    var myUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=278&entity_type=city&radius=1000"

    
    let clientKey = "8ca8132ea2011f2b1b5bcd0822a31984"
    
    typealias JSONStanard = [String:AnyObject]
    
    let zomatoClient = ZomatoClient()
    
    var resModels = [RestaurantMode]()
    
    //searchbar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text!
        let finalKeyword = keyword.replacingOccurrences(of: " ", with: "%20")
        fetchLocationID(text: finalKeyword)
//        print(myUrl)
        
    }
    

    
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
    
    func fetchLocationID(text:String) {
        
        
//        let keyword = searchBar.text
//        let finalKeyword = keyword?.replacingOccurrences(of: " ", with: "%20")
        let locationUrl = "https://developers.zomato.com/api/v2.1/locations?query=\(text)&count=1"
        
        let url = URL(string: locationUrl)
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue(clientKey, forHTTPHeaderField: "user-key")
        Alamofire.request(urlRequest).responseJSON(completionHandler: {
            response in
            do{
                var readableData = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! JSONStanard
                if let suggestedLocation = readableData["location_suggestions"] as? [JSONStanard]{
//                    print(suggestedLocation)
                    let location = suggestedLocation[0];
                    self.locationID = location["city_id"] as? Int
                    print(self.locationID!)
                    
                    self.myUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=\(self.locationID!)&entity_type=city&radius=1000"
                    self.resModels = [RestaurantMode]()
                    self.fetchData()
                    print(self.myUrl)
                }
            }
            catch{
                print(error)
            }
        })
        
        
        
//        return locationID!
    }
//    
//    func replaceSpaceInKeyword(keyword:String) -> String {
//        let newString = keyword.replacingOccurrences(of: " ", with: "%20")
//        return newString
//    }
    
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
                        
                        var address = String()
                        var longitude = String()
                        var latitude = String()
                        var image = UIImage()
                        
                        if let locations = myRes["location"] as? JSONStanard{
                            address = locations["address"] as! String
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
                        
                        let resModel = RestaurantMode(restaurantName: resName, location: address, longtitude: longitude, latitude: latitude, image:image)
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
