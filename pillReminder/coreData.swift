//
//  coreData.swift
//  pillReminder
//
//  Created by mohammad on 2/17/19.
//  Copyright © 2019 Don Mhmmd. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class coreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    ////Save time
    class func saveTime(dateTime: Date) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Values", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(dateTime, forKey: "startTime")
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    ////Fetch time
    class func fetchTimeObj() -> [Values]? {
        let context = getContext()
        var dateTime : [Values]? = nil
        do {
            dateTime = try context.fetch(Values.fetchRequest())
            return dateTime
        } catch {
            return dateTime
        }
    }
    ////Delete savedTime
    class func deleteWholeTime() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Values.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    //// set time
    class func setTime(dateTime: Date) -> Bool {
        deleteWholeTime()
        let ret =  saveTime(dateTime: dateTime)
        return ret
    }
    //// load saved time
    class func loadSavedTime() -> Values? {
        let tempTime : [Values]? = fetchTimeObj()
        if ((tempTime!.count) > 0) {
            return tempTime![0]
        } else {
            return nil
        }
    }

}
