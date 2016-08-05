//
//  EditWorkingDomainController_Ext.swift
//  workingSetProject_v2
//
//  Created by Osa on 8/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


extension EditWorkingDomainController: NSTableViewDataSource{
    
    
    
    func updateStatus(){
        
    }
    
    
    /*
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        //1
        //let managedContext = appDelegate.managedObjectContext
        let managedContext = singleton.coreDataObject.managedObjectContext
        //2
        let fetchRequest = NSFetchRequest(entityName: "WorkingDomain")
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            workingSets = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return workingSets.count ?? 0
    }
    */
    
    /*
     
     // Function sets the sorting schema, then calls on "reloadFileList()" to actually change table view.
     func tableView(tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
     print("Starting sort.")
     }
     
    */
    
}


extension EditWorkingDomainController: NSTableViewDelegate{
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        updateStatus()
    }
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        
        // 1 - Get Managed Object Context
        let managedContext = singleton.coreDataObject.managedObjectContext
        
        // 2 - Establish Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "WorkingDomain")
        
        // 3 - Attempt Fetch Request
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            workingSets = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // 4 - Value to Fill Table as per Row
        var value = workingSets[row].valueForKey("nameOfWD") as? String
        //var date = workingSets[row].valueForKey("dateLastUsed") as? String
        //print(date)
        // 5 Assign Value in Event that there is no Retrieved Value
        if(value == nil){
            value = "Unnamed"
        }
        
        // 6 - Specifying table column
        if tableColumn == tableView.tableColumns[0] {
            text = value!
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = "apple"
            cellIdentifier = "DateCellID"
        }
        
        // 7 - Fill cell content.
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        // 8
        return nil
    }
    
}