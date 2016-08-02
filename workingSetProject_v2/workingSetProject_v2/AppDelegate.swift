//
//  AppDelegate.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/3/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   
    
    
    let openWindowObject = windowManager()
    var windowController = NSWindowController()
    var serialPortObject: SerialPortManager!
  

    // PRIMARY FUNCTIONS
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // - 1 Calls function to initialize values for app.
        initializeApp()
        openWindowObject.setWindow("Main",nameOfWindowController: "WorkingDomainManager")
        windowController = openWindowObject.get_windowController()
    }

    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("WSDM is closing.")
    }

    
    
    // INTERFACE FUNCTIONS
    @IBAction func launchWSDM_Window(sender: AnyObject){
        // - 1 Launches WSDM window.
        windowController.showWindow(sender)
    }
    
    
    
    @IBAction func launchWindowManager(sender: AnyObject){
        singleton.openWindowObject.setWindow("Main", nameOfWindowController: "Edit User Settings Window")
        singleton.openWindowObject.runModalWindow()
    }
    
    
    
    
}

