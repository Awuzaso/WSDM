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
        
        
        
        
        let object = singleton.coreDataObject.getEntityObject("User_Attr", idKey: "pathToSaveWS", idName: "Blank")
        
        /*
        singleton.coreDataObject.setValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "dateLastAccessed", idName: "Blank", editName: singleton.getDate("EEEE, MMMM dd, yyyy, HH:mm:ss"))
        
         let timesAccessed = singleton.coreDataObject.getValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "timesAccessed", nameOfObject: "Blank")
            var nval = (timesAccessed as NSString).integerValue
             nval = nval + 1
        singleton.coreDataObject.setValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "timesAccessed", idName: "Blank", editName: "\(nval)")
        
        
        print( object )
        
        print( singleton.getDate("EEEE, MMMM dd, yyyy, HH:mm:ss") )
        print(nval)
 
        */
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

