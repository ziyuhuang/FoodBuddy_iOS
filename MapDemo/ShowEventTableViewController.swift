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
        
    }

//    func startObeserveDB(){
//        dbRef.observe(.value, with: {(snapshot:FIRDataSnapshot) in
//            var newEvents = [EventModel]()
//            for event in snapshot.children{
//                let eventObject = EventModel(snapshot:event as! FIRDataSnapshot)
//                newEvents.append(eventObject)
//            }
//        })
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
}
