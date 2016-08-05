//
//  AppDelegate_Ext.swift
//  workingSetProject_v2
//
//  Created by Osa on 8/2/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

extension AppDelegate{
    
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
            /*
            
            let currentDate = NSDate()
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_GR")
            
            
            dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            var convertedDate = dateFormatter.stringFromDate(currentDate)
            
            singleton.coreDataObject.setValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "dateCreated", idName: "Blank", editName: singleton.getDate("EEEE, MMMM dd, yyyy"))
            
            
            singleton.coreDataObject.setValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "dateLastAccessed", idName: "Blank", editName: singleton.getDate("EEEE, MMMM dd, yyyy, HH:mm:ss"))
            
            singleton.coreDataObject.setValueOfEntityObject("User_Attr", idKey: "pathToSaveWS", nameOfKey: "timesAccessed", idName: "Blank", editName: "0")
            */
            // 1 - Setting window object.
            //let openWindowObject = windowManager()
            singleton.openWindowObject.setWindow("Main",nameOfWindowController: "Edit User Settings Window")
            // 2 - Initiate the window.
            singleton.openWindowObject.runModalWindow()
            
            
        }
        else{ // Case if program has been used before.
            
            
             let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
            print( serialPortManager.availablePorts )
            
            
            // Load user values for session.
            print("Profile detected.")
            print(singleton.serialPath)
            singleton.serialPortObject = SerialPortManager(pathName: singleton.serialPath ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
             print("Profile detected.")
        }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
