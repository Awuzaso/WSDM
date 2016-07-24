//
//  EditWorkingDomainController.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/23/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class EditWorkingDomainController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.stringValue = singleton.openedWD
        // Do view setup here.
    }
    
    
    @IBOutlet weak var tableViewEWD: NSTableView!
    
    @IBOutlet weak var textLabel: NSTextField!
    
 
    @IBAction func addCurrentCard_Button(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("AW", object: nil)
        
    }
    
    
    @IBAction func removePrevCard_Button(sender: AnyObject) {
        
        
        
        
        
    }
    
    
    @IBAction func save_Button(sender: AnyObject) {
        print("Saving...")
        let valueToSend = textLabel.stringValue
        singleton.openedWD = valueToSend
         NSNotificationCenter.defaultCenter().postNotificationName("saver", object: nil)
        singleton.openWindowObject.stopEvents()
        
    }
    
    
    
    
    
    @IBAction func cancel_Button(sender: AnyObject) {
        
        singleton.openWindowObject.stopEvents()
        
        
        
    }
}
