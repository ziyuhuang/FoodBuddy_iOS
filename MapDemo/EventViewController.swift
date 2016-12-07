//
//  EventViewController.swift
//  MapDemo
//
//  Created by ZIYU HUANG on 12/6/16.
//  Copyright © 2016 ZIYU HUANG. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    
    @IBOutlet weak var eventTitleTextField: UITextField?
    
    @IBOutlet weak var eventTimeTextField: UITextField?
    
    var restaurantName = String()
    var restaurantLocation = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameLabel.text = restaurantName
        restaurantLocationLabel.text = restaurantLocation

        // Do any additional setup after loading the view.
    }

    
    @IBAction func createEvent(_ sender: Any) {
        var eventTitle = String()
        var eventTime = String()
        if self.eventTimeTextField?.text?.isEmpty ?? true{
            self.eventTimeTextField!.backgroundColor = UIColor.red
        }else{
            eventTime = (self.eventTimeTextField?.text)!
            print(eventTime)
        }
        
        if self.eventTitleTextField?.text?.isEmpty ?? true{
            self.eventTitleTextField?.backgroundColor = UIColor.red
        }else{
            eventTitle = (self.eventTitleTextField?.text!)!
            print(eventTitle)
        }
    }

}
