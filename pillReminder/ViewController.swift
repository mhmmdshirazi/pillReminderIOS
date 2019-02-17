//
//  ViewController.swift
//  pillReminder
//
//  Created by mohammad on 2/17/19.
//  Copyright © 2019 Don Mhmmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//////// Outlets
    @IBOutlet weak var dateOL: UITextField!
//////// Variables
    var savedTime : Date?
    let calendar = Calendar.current
//////// Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTime = coreDataHandler.loadSavedTime()?.startTime
        dateOL.textAlignment = NSTextAlignment.center
        if savedTime != nil {
            let hour = calendar.component(.hour, from: savedTime!)
            let minutes = calendar.component(.minute, from: savedTime!)
            dateOL.text = String(format: "%02d:%02d", hour, minutes)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
//////// Actions
    @IBAction func setDate(_ sender: UIButton) {
        let date = Date()
        savedTime = date
        let hour = calendar.component(.hour, from: savedTime!)
        let minutes = calendar.component(.minute, from: savedTime!)
        dateOL.text = "\(hour):\(minutes)"
        coreDataHandler.setTime(dateTime: date)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let selectedDate = Date(timeInterval: 40, since: date)
        print (date,selectedDate)
        delegate?.scheduleNotification(at: selectedDate)
    }
    
}


