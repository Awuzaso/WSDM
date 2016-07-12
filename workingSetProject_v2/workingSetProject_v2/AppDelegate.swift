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
   
    var cardValue: String!
    
    
    
    
    
    //var coreDataObject = dataCore()
    
    
    
    var serialPortObject: SerialPortManager!
    
    
    
    
    func set_CardValue(value:String){
        cardValue = value
        print(cardValue)
    }
    
    
    
    
    
    func determineIfFirstTimeLaunch()->Bool{
        // 1 -  Get user preferences entity, "User Attrib"
        let result = singleton.coreDataObject.getCountOfDataObjects("User_Attr")//coreDataObject.getCountOfDataObjects("User_Attr")
      
        // 2 - Assign cout of result to "result_count"
       
        let result_count = result
        // 3 - Initialize Bool var "if_firstTimeLaunch".
        var if_firstTimeLaunch: Bool!
        // 4 - Compare bool value.
        // 4.1 - If it is the case that there are no objects in "User_Attrib", this indicates that this is the first time of use.
        if(result_count == 0){
            if_firstTimeLaunch = true
        }
            // 4.2 - If it is not the case, this is indicative of persisting use.
        else{
            if_firstTimeLaunch = false
        }
        // 5 - Return value.
        return if_firstTimeLaunch
    }

    
    
    
    
    
    
    
    
    func initializeApp(){
        let evalValue = determineIfFirstTimeLaunch()
        
        if(evalValue == true){ // Case if program is being used for the first time.
            // Open window to query user to set 'user pref'.
            // Load user values for session.
            print("No profile detected!")
            
            singleton.coreDataObject.addEntityObject("User_Attr", nameOfKey: "pathToSaveWS", nameOfObject: "Blank")
            
                // 1 - Setting window object.
                    //let openWindowObject = windowManager()
                    singleton.openWindowObject.setWindow("Main",nameOfWindowController: "Edit User Settings Window")
                // 2 - Initiate the window.
                    singleton.openWindowObject.runModalWindow()
            
            
        }
        else{ // Case if program has been used before.
            // Load user values for session.
            print("Profile detected.")
                singleton.serialPortObject = SerialPortManager(pathName: singleton.serialPath ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
            
           
        }
    }
    
    
    
    
    
    @IBAction func launchWindowManager(sender: AnyObject){
        singleton.openWindowObject.setWindow("Main", nameOfWindowController: "Edit User Settings Window")
        singleton.openWindowObject.runModalWindow()
    }
    
    
   
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        initializeApp()
        
        let workDomain = singleton.coreDataObject.getEntityObject("WorkingDomain", idKey: "nameOfWD", idName: "Apple")
        
        let associatedFile = singleton.coreDataObject.getDataObjects("File") //workDomain.valueForKey("associatedFiles")
        
        for i in associatedFile{
            let a = i.valueForKey("nameOfFile") as! String
            //let b = i.valueForKey("associatedWD") as! String
         
            print(a)
            print(    i.valueForKey("nameOfPath")  )
        }
       // print(  associatedFile )
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    
}

