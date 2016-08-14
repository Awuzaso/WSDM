//
//  debuggingWindow.swift
//  workingSetProject_v2
//
//  Created by Osa on 8/14/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class debuggingWindow: NSViewController {

    @IBOutlet weak var debuggingText: NSTextField!
    
    func updateValueStatus(){
        debuggingText.stringValue = " canAssociateVar: \(singleton.canAssociateVar)\n "
   
        if(singleton.readCard != nil){
            debuggingText.stringValue = debuggingText.stringValue + " readCard: \(singleton.readCard.valueForKey("rfidValue"))\n "
        }
        
        if(singleton.openedWD != nil){
            debuggingText.stringValue = debuggingText.stringValue + " openedWD: \(singleton.openedWD)\n "
        }
        

            debuggingText.stringValue = debuggingText.stringValue + " serialPath: \(singleton.serialPath)\n "
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateValueStatus()
        debuggingText.stringValue = ""
        // Do view setup here.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateValueStatus",name:"UVS", object: nil)

    }
    
}
