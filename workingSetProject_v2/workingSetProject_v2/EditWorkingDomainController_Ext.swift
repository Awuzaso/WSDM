//
//  EditWorkingDomainController_Ext.swift
//  workingSetProject_v2
//
//  Created by Osa on 8/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


extension EditWorkingDomainController: NSTableViewDataSource{
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
     
        
        let fetchedWD:NSManagedObject!
        
        
        //Here we will specify the contents for associated files of WD.
        
        // 1 - Get Managed Object Context
        let managedContext = singleton.coreDataObject.managedObjectContext
        
        // 2 - Establish Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "WorkingDomain")
        
        // 3 - Specify Predicate
        //let predicate = NSPredicate(format: "nameOfWD",loadedWDName)
        
        
        let predicate = NSPredicate(format: "%K == %@","nameOfWD",singleton.openedWD)
        
        
        fetchRequest.predicate = predicate
        
        // 3 - Attempt Fetch Request
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            cardsAssociated = results as! [NSManagedObject]
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        
        
        
        let spec = cardsAssociated[0]
        
       
        
       
        let list = spec.mutableSetValueForKey("associatedCards")
        ///*
        return list.count ?? 0
        //*/
        //return 2
    }
    
    
    
    func updateStatus(){
        
    }
    
    
    
    
}


extension EditWorkingDomainController: NSTableViewDelegate{
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        updateStatus()
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        let spec = cardsAssociated[0]
        
        let list = spec.mutableSetValueForKey("associatedCards")
        
        var isEmpty:Bool!
        
        if(list.count == 0){
            isEmpty = true
        }
        else{
            isEmpty = false
        }

        
        if( isEmpty == false){
            
            var associatedObjects : [String] = []
       
        var text:String = "text"
        var cellIdentifier: String = ""
        
            for i in list{
                let item = i.valueForKey("rfidValue") as! String
                print( item )
                
                associatedObjects.append(item)
            }
            
            
            var value = associatedObjects[row]
            
            
         
            
            // 2
            if tableColumn == tableView.tableColumns[0] {
                
                text =  value //"thing" //cardsAssociated[row].valueForKey("rfidValue") as! String
                cellIdentifier = "NameCellID"
            } else if tableColumn == tableView.tableColumns[1] {
                text = "Thing"
                cellIdentifier = "DateCellID"
            }
            
            // 3
            if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
                return cell
            }
        }
        
        
        return nil
    }
  
    
}