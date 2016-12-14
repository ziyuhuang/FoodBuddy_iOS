//
//  EventViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/6/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    
    @IBOutlet weak var eventTitleTextField: UITextField?
    
    @IBOutlet weak var eventTimeTextField: UITextField?
    
    @IBOutlet weak var eventMessageField: UITextView!
    
    var restaurantName = String()
    var eventMessage = String()
    var restaurantLocation = String()
    var locationLogitude = Double()
    var locationLatidue = Double()
    var image:UIImage?
    
    var dbRef:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameLabel.text = restaurantName
        restaurantLocationLabel.text = restaurantLocation

        dbRef = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/").child("events")
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation"{
            if let mapVC = segue.destination as? GoogleViewController{
                mapVC.latitude = locationLatidue
                mapVC.longitude = locationLogitude
                mapVC.restaurant = restaurantName
//                print(mapVC.longitude)
            }
        }
        
//        if segue.identifier == "loadEvent"{
//            if let eventVC = segue.destination as? ShowEventTableViewController{
//                
//            }
//        }
    }
    
    @IBAction func createEvent(_ sender: Any) {
        
        var eventTitleEmptyFlag = false
        var eventTimeEmptyFlag = false
        eventMessage = eventMessageField.text
        
        var eventTitle = String()
        var eventTime = String()
        if self.eventTimeTextField?.text?.isEmpty ?? true{
            self.eventTimeTextField!.backgroundColor = UIColor.red
        }else{
            eventTime = (self.eventTimeTextField?.text)!
            eventTitleEmptyFlag = true
            print(eventTime)
        }
        
        if self.eventTitleTextField?.text?.isEmpty ?? true{
            self.eventTitleTextField?.backgroundColor = UIColor.red
        }else{
            eventTitle = (self.eventTitleTextField?.text!)!
            eventTimeEmptyFlag = true
            print(eventTitle)
        }
        
        //if the text field are both filled, create event
        if(eventTimeEmptyFlag && eventTitleEmptyFlag){
            let eventRef = self.dbRef.child(eventTitle.lowercased())
            
            let storageRef = FIRStorage.storage().reference(forURL: "gs://foodbuddy-8e869.appspot.com").child("images/myImage2.png")
            
            if let uploadData = UIImagePNGRepresentation(image!){
                storageRef.put(uploadData, metadata: nil, completion: {
                    (metadata, error) in
                    
                    if error != nil{
                        print(error!)
                        return
                    }
                    
                    if let imageDataUrl = metadata?.downloadURL()?.absoluteString{
                        //                   self.imageUrl = imageDataUrl
                        //                    print(self.imageUrl)
                        let event = EventModel(eventTitle: eventTitle, eventMessage: self.eventMessage, eventLocation: self.restaurantLocation, eventTime: eventTime, eventRestaurant: self.restaurantName, longitude:self.locationLogitude, latitude:self.locationLatidue, imageUrl:imageDataUrl)
                        
                        
                        eventRef.setValue(event.toAnyObject())
                        self.performSegue(withIdentifier: "joinEvent", sender: nil)
                        
                    }else{
                        let imageDataUrl = ""
                        let event = EventModel(eventTitle: eventTitle, eventMessage: self.eventMessage, eventLocation: self.restaurantLocation, eventTime: eventTime, eventRestaurant: self.restaurantName, longitude:self.locationLogitude, latitude:self.locationLatidue, imageUrl:imageDataUrl)
                        
                        
                        eventRef.setValue(event.toAnyObject())
                        self.performSegue(withIdentifier: "joinEvent", sender: nil)
                    }
                })
            } 
        }
    }
    
    func uploadRestaurantImageToFireBase(){
        
        
    }

}
