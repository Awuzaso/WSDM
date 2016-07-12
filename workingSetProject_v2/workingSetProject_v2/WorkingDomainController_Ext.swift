//
//  WorkingDomainController_Ext.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/9/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


extension WorkingDomainController : NSTableViewDataSource {

    /*This function is called everytime there is a change in the table view.*/
    func updateStatus() {
        // 1 - Get collection of objects from object graph.
        workingSets = singleton.coreDataObject.getDataObjects("WorkingDomain")
        
        // 2 - Set the current selection of working set from table view.
        //let item = workingSets[tableView!.selectedRow]
        //nameOfWS =  wdTable.getItemSelected_String(tableView, managedObjectArray: workingSets, objectAttr: "SmartFOlder")       /*item.valueForKey("smartFOlder") as? String*/
        
        // 3 - Change the status label beneath the table view dynamically as selection changes.
        statusLabel.stringValue = "Directory Path"
        
        // 4 - When a working set is seleted from the table view, launch window buttons are then made available to be pressed.
        switchOnOffButtons(true)
    }
    
    
    
    // Fine as is.
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        //1
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
    
    
    
    
    // May need to change.
    func tableView(tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        print("Sorting.")
        // 1
        guard let sortDescriptor = tableView.sortDescriptors.first else {
            return
        }
        if let order = Directory.FileOrder(rawValue: sortDescriptor.key! ) {
            // 2
            sortOrder = order
            sortAscending = sortDescriptor.ascending
            reloadFileList()
        }
    }

    
}




extension WorkingDomainController : NSTableViewDelegate {
    
    
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
        var value = workingSets[row].valueForKey("associatedFiles") as? String
        
        
        // 5 Assign Value in Event that there is no Retrieved Value
        if(value == nil){
            value = "Unnamed"
        }
        
        // 6 - Specifying table column
        if tableColumn == tableView.tableColumns[0] {
            text = value!
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = "Value"
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