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
    
    
    
    
    
    
    
    
    @IBOutlet weak var addCurrentCardButton: NSButton!
    
    @IBOutlet weak var removePrevCardButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewEWD!.setDelegate(self)
        tableViewEWD!.setDataSource(self)
        tableViewEWD!.target = self
        
        
        
        
        
        
        
        
        
        textLabel.stringValue = singleton.openedWD
        // Do view setup here.
        if( singleton.canAssociateVar == false ){
            addCurrentCardButton.enabled = false
            removePrevCardButton.enabled = false
            
        }
        
        
        
        
    }
    
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)   // Calls sorting function. Returns sorted array
        tableViewEWD!.reloadData()
    }
    
    
    
    @IBOutlet weak var tableViewEWD: NSTableView!
    
    @IBOutlet weak var textLabel: NSTextField!
    
 
    @IBAction func addCurrentCard_Button(sender: AnyObject) {
        //print( singleton.readCard.valueForKey("associatedWD") )
        //NSNotificationCenter.defaultCenter().postNotificationName("AW", object: nil)
        
        ///*
        let openedWD = singleton.coreDataObject.getEntityObject("WorkingDomain", idKey: "nameOfWD", idName: singleton.openedWD)
        
        //print( openedWD )
        
        openedWD.setValue(singleton.readCard, forKey: "associatedCards")
        
        
        
        do{
            try singleton.coreDataObject.managedObjectContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
        print( "The associated card for \(openedWD.valueForKey("nameOfWD"))" )
        print( (openedWD.valueForKey("associatedCards"))?.valueForKey("rfidValue") )
        
        //singleton.coreDataObject.createRelationship(openedWD, objectTwo: singleton.readCard, relationshipType: "associatedCards")
        
        //singleton.coreDataObject.setValueOfEntityObject("WorkingDomain", idKey: "nameOfWD", nameOfKey: "timesAssociated", idName: singleton.openedWD , editName: "1" )
        
        //print( openedWD )
        //*/
    }
    
    
    @IBAction func removePrevCard_Button(sender: AnyObject) {
        
        
        
        
        
    }
    
    
    @IBAction func save_Button(sender: AnyObject) {
        print("Saving...")
        let valueToSend = textLabel.stringValue
        singleton.openedWD = valueToSend
         NSNotificationCenter.defaultCenter().postNotificationName("saver", object: nil)
        //singleton.openWindowObject.stopEvents()
        
    }
    
    
    
    
    
    @IBAction func cancel_Button(sender: AnyObject) {
        
        singleton.openWindowObject.stopEvents()
        
        
        
    }
}
