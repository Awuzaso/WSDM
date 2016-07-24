//
//  ViewController.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/3/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class workingSetManagerViewController: NSViewController {
    var windowController : NSWindowController?
    
    
    
    
    let launchWindowTable = tableViewManager()
    
    /*Variables for Sorting Table View*/
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true
    var directory:Directory?
    var directoryItems:[Metadata]?
    
    

    /*Variables*/
    var nameOfWS: String! //Selected WS
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    
    
    /*Outlets for Table View*/
    @IBOutlet weak var statusLabel: NSTextField!

    
    /*Outlets for Buttons*/
    
    @IBOutlet weak var openWDButton: NSButton!
    @IBOutlet weak var associateWDButton: NSButton!
    @IBOutlet weak var deleteWDButton: NSButton!
    
    
    
    /*Function for toggling between off and on state of buttons.*/
    func switchOnOffButtons(openActive:Bool,deleteActive:Bool,associateActive:Bool){
        openWDButton.enabled = openActive
        //deleteWDButton.enabled = deleteActive
        //associateWDButton.enabled  = associateActive
    }

    
    
    
    
    @IBOutlet weak var tableView: NSTableView!
    
    /*Set-up View*/
    override func viewDidLoad() {
        
        
       
        
        super.viewDidLoad()
        tableView!.setDelegate(self)
        tableView!.setDataSource(self)
        tableView!.target = self
        tableView.doubleAction = "tableViewDoubleClick:"
        //Setting up sorting configuration:
        
        
        
        

        
        let nameDesc = "Name"
        let dateDesc = "Date"
        // 1
        let descriptorName_01 = NSSortDescriptor(key: Directory.FileOrder.Name.rawValue, ascending: true)
        let descriptorName_02 = NSSortDescriptor(key: Directory.FileOrder.Date.rawValue, ascending: true)
        
        // 2
        tableView.tableColumns[0].sortDescriptorPrototype = descriptorName_01;
        tableView.tableColumns[0].sortDescriptorPrototype = descriptorName_02;
        
        switchOnOffButtons(false,deleteActive: false,associateActive: false)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeStatus:",name:"load", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTableView:",name:"update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "launchAssociatedWindow:", name: "associateWindow", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AssociateWDButton", name: "AW", object: nil)
        
       
        
    }
    
    override func awakeFromNib() {
        
    }
    
    
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)   // Calls sorting function. Returns sorted array
        tableView!.reloadData()
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
            if let url = representedObject as? NSURL {
                directory = Directory(folderURL: url)
                reloadFileList()
                
            }
        }
    }

    
    
    func changeStatus(notification: NSNotification){
        self.switchOnOffButtons(true, deleteActive: true, associateActive: true)
    }
    
    func updateTableView(notification: NSNotification){
        self.reloadFileList()
    }
    
    func launchAssociatedWindow(notification: NSNotification){
        print("Launch!")
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "AWindow")
        // 2 - Setting the values of the window object.
        windowController = openWindowObject.get_windowController()
        let openWindowViewController = windowController!.contentViewController as! WorkingDomainController
        
        
        
        // 3 - Initiate the window.
        windowController!.showWindow(nil)
    }
    
    
    
    
    // MARK: - Button Actions
    
    @IBAction func addNewWDButton(sender: AnyObject) {
        print("'Add new button' was pressed.")
        singleton.coreDataObject.addEntityObject("WorkingDomain", nameOfKey: "nameOfWD", nameOfObject: "Untitled Working Domain")
        singleton.openedWD = "Untitled Working Domain"
        
        /*
        singleton.coreDataObject.editEntityObject("WorkingDomain", nameOfKey: "dateLastUsed", oldName: "Untitled Working Domain", editName: "today")
        
        print(singleton.coreDataObject.getValueOfEntityObject("WorkingDomain", idKey: "nameOfWD", nameOfKey: "dateLastUsed", nameOfObject: "Untitled Working Domain"))
        */
        
       
        
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "AWindow")
        // 2 - Setting the values of the window object.
        windowController = openWindowObject.get_windowController()
        let openWindowViewController = windowController!.contentViewController as! WorkingDomainController
        
        
        //openWindowViewController.nameOfWD.stringValue = "Untitled Working Domain"
        
        //openWindowViewController.loadedWDName = "Untitled Working Domain"
       
        
       
        
        // 3 - Initiate the window.
        windowController!.showWindow(sender)

        
        
        
        
        reloadFileList()
        
        // Enable buttons.
        switchOnOffButtons(true,deleteActive: true,associateActive: false)
    }
    
    
    @IBAction func openWDButton(sender: AnyObject) {
        print("'Open button' was pressed.")
        
        
        singleton.openedWD = nameOfWS
        
        
        
        
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "AWindow")
        // 2 - Setting the values of the window object.
        windowController = openWindowObject.get_windowController()
        let openWindowViewController = windowController!.contentViewController as! WorkingDomainController
        
        
       
        // 3 - Initiate the window.
        windowController!.showWindow(sender)
        
        
        
      

 
    }

    @IBAction func deleteWDButton(sender: AnyObject) {
        singleton.coreDataObject.deleteEntityObject("WorkingDomain", nameOfKey: "nameOfWD", nameOfObject: nameOfWS)
        reloadFileList()
    }
    
    func AW_notif(){
        print("Associating...")
        nameOfWS = singleton.openedWD
        AssociateWDButton()
    }
    
    
    
  func AssociateWDButton() {
        
        singleton.coreDataObject.setValueOfEntityObject("WorkingDomain", idKey: "nameOfWD", nameOfKey: "tagID", idName: nameOfWS, editName: singleton.rfidValue)
        
        
        //singleton.coreDataObject.
        
        
        
        // Ending Operation
        
        // Switch off 'AssociateWD' button
        //switchOnOffButtons(true, deleteActive: true, associateActive: false)
        
        // Reset Value for singleton's rfid_value.
        
        singleton.rfidValue = "NONE"
        singleton.openedWD = nameOfWS
        
        print(singleton.rfidValue)
        /*
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "AWindow")
        // 2 - Setting the values of the window object.
        windowController = openWindowObject.get_windowController()
        let openWindowViewController = windowController!.contentViewController as! WorkingDomainController
        
        
        
        // 3 - Initiate the window.
        windowController!.showWindow(sender)
        &/
        */
    }
}

