//
//  MyEventListTableViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/18/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit

class MyEventListTableViewController: UITableViewController {
    
    var userEventList = [String]()
    
    var myEventList = [EventModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(myEventList.count)

        navigationItem.title = "My Event List"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myEventList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let eventLabel = cell.viewWithTag(1) as! UILabel
        let eventTimeLabel = cell.viewWithTag(2) as! UILabel
        let eventLocationLabel = cell.viewWithTag(3) as! UILabel
        
        eventLabel.text = "Event: " + myEventList[indexPath.row].eventTitle
        eventTimeLabel.text = myEventList[indexPath.row].eventTime
        eventLocationLabel.text = "Location: " + myEventList[indexPath.row].eventLocation
        return cell
    }
}
