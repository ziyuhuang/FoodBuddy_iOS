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
    
    var events = [EventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/").child("events")
        startObeserveDB()
        
    }

    func startObeserveDB(){
        dbRef.observe(.value, with: {(snapshot:FIRDataSnapshot) in
            var newEvents = [EventModel]()
            for event in snapshot.children{
                let eventObject = EventModel(snapshot:event as! FIRDataSnapshot)
                newEvents.append(eventObject)
            }
            
            self.events = newEvents
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

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
        let titleLabel = cell.viewWithTag(2) as! UILabel
        let locationLabel = cell.viewWithTag(3) as! UILabel
        let timeLabel = cell.viewWithTag(4) as! UILabel
        let messageTextView = cell.viewWithTag(5) as! UITextView
        messageTextView.isEditable = false
        
        locationLabel.text = events[indexPath.row].eventLocation
        titleLabel.text = events[indexPath.row].eventTitle
        timeLabel.text =  "Time: " + events[indexPath.row].eventTime
        messageTextView.text = "Message from Host: \n" + events[indexPath.row].eventMessage
        return cell
    }
}
