//
//  EditWorkingDomainController.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/23/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class EditWorkingDomainController: NSViewController {

    
    /*Variables for Sorting Table View*/
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true
    var directory:Directory?
    var directoryItems:[Metadata]?
    
    /*Variables*/
    var nameOfCard: String! //Selected WS
    var cardsAssociated = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    
    
    
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var addCurrentCardButton: NSButton!
    @IBOutlet weak var removePrevCardButton: NSButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.setDelegate(self)
        tableView.setDataSource(self)
        textLabel.stringValue = singleton.openedWD
        
        if( singleton.canAssociateVar == false ){
            addCurrentCardButton.enabled = false
            removePrevCardButton.enabled = false
        }
    }
    
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)   // Calls sorting function. Returns sorted array
        tableView.reloadData()
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
           
                reloadFileList()
                
            
        }
    }

   
    
 
    @IBAction func addCurrentCard_Button(sender: AnyObject) {
        
        let openedWD = singleton.coreDataObject.getEntityObject("WorkingDomain", idKey: "nameOfWD", idName: singleton.openedWD)
        
        print("This is the RFID value that's current: \(singleton.readCard.valueForKey("rfidValue") as! String )")
        
        
        let cards = openedWD.mutableSetValueForKey("associatedCards")
        
        cards.addObject(singleton.readCard)
        
        print( openedWD.valueForKey("associatedCards") )
        
        reloadFileList()
        
        //singleton.coreDataObject.createRelationship(openedWD, objectTwo: singleton.readCard, relationshipType: "associatedCards")
        
        //print(openedWD.valueForKey("associatedCards"))
        
       
    }
    
    
    @IBAction func removePrevCard_Button(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func save_Button(sender: AnyObject) {
        print("Saving...")
        let valueToSend = textLabel.stringValue
        singleton.openedWD = valueToSend
        NSNotificationCenter.defaultCenter().postNotificationName("saver", object: nil)
    }
    
    
    @IBAction func cancel_Button(sender: AnyObject) {
        singleton.openWindowObject.stopEvents()
    }
    
    
    
}
