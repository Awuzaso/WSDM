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
   
    
        /*Sets up constants.*/
            let openWindowObject = windowManager()
    
        /*Sets up varuables.*/
            var windowController = NSWindowController()
            var serialPortObject: SerialPortManager!
  

    // PRIMARY FUNCTIONS
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // - 1 Calls function to initialize values for app.
            initializeApp()
        
        // - 2 - Initialize WSDM window
            init_WSDM_Window()
        
        // - 3 - Launch WSDM window.
            launchWSDM_Window(self)
        
    }

    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    // INTERFACE FUNCTIONS
    @IBAction func launchWSDM_Window(sender: AnyObject){
        // - 1 Launches preivously set up WSDM window.
            windowController.showWindow(sender)
    }
    
    @IBAction func launchWindowManager(sender: AnyObject){
        // - 1 Sets up window object.
            singleton.openWindowObject.setWindow("Main", nameOfWindowController: "Edit User Settings Window")
        // 2 - Runs modal session of window object.
            singleton.openWindowObject.runModalWindow()
    }
    
    
    
    
}

