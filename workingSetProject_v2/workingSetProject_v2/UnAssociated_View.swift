//
//  UnAssociated_View.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/5/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class UnAssociated_View: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
    @IBAction func OK_Button(sender: AnyObject) {
        singleton.canAssociateVar = true
        singleton.openWindowObject.stopEvents()
    }
    
    
    @IBAction func Cancel(sender: AnyObject) {
        singleton.openWindowObject.stopEvents()
    }
    
    
    
}
