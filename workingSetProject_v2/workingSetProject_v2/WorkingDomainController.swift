//
//  WorkingDomainController.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/5/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class WorkingDomainController: NSViewController {

    
    /*WD Managed Object.*/
    //let workingDomainObject = NSManagedObject
    
    
    
    let wdTable = tableViewManager()
    
    var loadedWDName = "Value"
    var wdAccDate:NSDate!
    
    
    
    
    @IBOutlet weak var nameOfWD: NSTextField!
    
    
    /*Variables for Sorting Table View*/
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true
    
    /*Outlets for Buttons*/
    
    
    
    
    
    
    
    
    /*Outlets for Table View*/
    @IBOutlet weak var statusLabel: NSTextField!
    //@IBOutlet weak var tableView: NSTableView!
    
    
    /*Variables*/
    var nameOfWS = "Stuff" //Selected WS
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    
    
    /*Function for toggling between off and on state of buttons.*/
    func switchOnOffButtons(isActive:Bool){
      // Do stuff.
    }
    
    
    /*Set-up View*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //loadedWDName = nameOfWD.stringValue
        
        
        print("The value is now: \(singleton.openedWD)")
        nameOfWD.stringValue = singleton.openedWD
        
        loadedWDName = nameOfWD.stringValue
        
                
        // 3 - Toggle Button States
        switchOnOffButtons(false)
        
    }

    override func awakeFromNib() {
        
    }
    
    
    @IBAction func saveNameChange_Button(sender: AnyObject) {
        
        

        
        
        
        
        
       // let collection = singleton.coreDataObject.getDataObjects("WorkingDomain")
        
        
        
        //print(loadedWDName)
        
        singleton.coreDataObject.editEntityObject("WorkingDomain", nameOfKey: "nameOfWD", oldName: loadedWDName, editName: nameOfWD.stringValue)
        
        
        
        
        
        
        
        

        
        
        
        
        
        
        
        loadedWDName = nameOfWD.stringValue
        
      
        /*
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "WorkingDomainManager")
        // 2 - Setting the values of the window object.
        let windowController = openWindowObject.get_windowController()
        let openWindowViewController = windowController.contentViewController as! workingSetManagerViewController
        openWindowViewController.reloadFileList()
        */
        
          NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil)
        
        print("Saved!")
        
    }
    
    
    
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
        //tableView!.reloadData()
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            reloadFileList()
        }
    }
}
