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
    @IBOutlet weak var nextPill: UITextView!
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
            nextPill.text = String(format: "%02d:%02d", hour + 2, minutes)
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
        let hourr = calendar.component(.hour, from: selectedDate)
        let minutess = calendar.component(.minute, from: selectedDate)
        print (date,selectedDate)
        nextPill.text = String(format: "%02d:%02d", hourr, minutess)
        delegate?.scheduleNotification(at: selectedDate)
    }
    
}


