//
//  ShowEventTableViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/7/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit
import Firebase
class ShowEventTableViewController: UITableViewController {

   
    var dbRef:FIRDatabaseReference!
    
    var userRef:FIRDatabaseReference!
    
    //test purpose
    var ref_:FIRDatabaseReference!
    
    var events = [EventModel]()
    
    var myEvents = [EventModel]()
    
    var snapshopkeys = [String]()
    
    //temp solution, store the "only one" event
    var eventIDList = [String]()
    
    //test current auto id key
    var curEventId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/").child("events")
        
        ref_ = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/").child("events")
        

        navigationItem.title = "Tap to Join"
        startObeserveDB()
//        printAUserEvent()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myEvents = [EventModel]()
    }
    
    func getUserUid(){
        
        
    }

    func startObeserveDB(){
        var newEvents = [EventModel]()
        self.dbRef.observe(FIRDataEventType.childAdded, with: {
            (snapshot:FIRDataSnapshot) in
            
            self.snapshopkeys.append(snapshot.key)
            
            for event in snapshot.children{
//                print(event)
                let eventObject = EventModel(snapshot:event as! FIRDataSnapshot)
                newEvents.append(eventObject)
            }
            
            self.events = newEvents
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

//
//    @IBAction func joinEvent(_ sender: UIButton) {
//        
//    }
//    
    
    func printAUserEvent(child:String!){
        
        let finalRef = ref_.child(child)
        var temp = [EventModel]()
        finalRef.observe(.value, with: {
            snapshot in
            
            
            for event in snapshot.children{
                let eventObject = EventModel(snapshot:event as! FIRDataSnapshot)
                temp.append(eventObject)
                print(eventObject)
            }
            
            self.myEvents = temp
            self.performSegue(withIdentifier: "myEventList", sender: nil)
        })
        
        print(222222222)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
//        let restaurantImageView = cell.viewWithTag(1) as! UIImageView
        let restaurantImageView = cell.viewWithTag(1) as! UIImageView
        let titleLabel = cell.viewWithTag(2) as! UILabel
        let locationLabel = cell.viewWithTag(3) as! UILabel
        let timeLabel = cell.viewWithTag(4) as! UILabel
        let messageTextView = cell.viewWithTag(5) as! UITextView
        let hostUrlLabel = cell.viewWithTag(6) as! UILabel
        messageTextView.isEditable = false
        
        if let imageUrl = events[indexPath.row].imageUrl{
            let url = NSURL(string: imageUrl) as! URL
            let imageData = NSData(contentsOf: url) as! Data
            let image = UIImage(data: imageData)!
            restaurantImageView.image = image
        }

        locationLabel.text = events[indexPath.row].eventLocation
        titleLabel.text = events[indexPath.row].eventTitle
        timeLabel.text =  "Time: " + events[indexPath.row].eventTime
        messageTextView.text = "Message from Host: \n" + events[indexPath.row].eventMessage
        hostUrlLabel.text = "Host By: " + events[indexPath.row].hostUser
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventOrderNumber = indexPath.row
        print(snapshopkeys[eventOrderNumber])
        
        
        //ask user if they wants to join the event
        let alertcontroller = UIAlertController(title: "Event", message: "Are you sure you want to join the event?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
     
        
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: { alertAction in
            
            
            FIRAuth.auth()!.addStateDidChangeListener { auth, user in
                guard let user = user else { return }
                
//                print(user.uid)
//                print(self.snapshopkeys[eventOrderNumber]+"==================here")
                
                self.eventIDList.append(self.snapshopkeys[eventOrderNumber])
                
                self.curEventId = self.snapshopkeys[eventOrderNumber]
                
                let value = [self.snapshopkeys[eventOrderNumber]:true]
                
                self.userRef = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/").child("users").child(user.uid).child("events")
                
                self.userRef.setValue(value)
                
                self.printAUserEvent(child: self.curEventId)
//                print(111111111)
                
                
            }
            
            
        })
    
        alertcontroller.addAction(okAction)
        alertcontroller.addAction(cancelAction)
        
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myEventList"{
            let myEventListVC = segue.destination as! MyEventListTableViewController
//            myEventListVC.userEventList = eventIDList
            myEventListVC.myEventList = self.myEvents
        }
    }
}
