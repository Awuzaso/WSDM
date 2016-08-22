//
//  AppDelegate_Ext.swift
//  workingSetProject_v2
//
//  Created by Osa on 8/2/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

extension AppDelegate{
    
    func init_WSDM_Window(){
        openWindowObject.setWindow("Main",nameOfWindowController: "WorkingDomainManager")
        windowController = openWindowObject.get_windowController()
        ///
        openWindowObject2.setWindow("Main",nameOfWindowController: "UAWindow")
        unassocCardWinController = openWindowObject2.get_windowController()
        //
        
    }
    

    func determineIfFirstTimeLaunch()->Bool{
        // 1 -  Get user preferences entity, "User Attrib"
            let result = singleton.coreDataObject.getCountOfDataObjects("User_Attr")
        
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
        
        let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
        let serPort = serialPortManager.availablePorts
        let selectedPort = serPort[0]
        ///*

        let pthNm = "/dev/cu.\(selectedPort)"
        print( pthNm )
        singleton.serialPortObject = SerialPortManager(pathName: pthNm ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
        
        singleton.serialPath = pthNm
        
        //*/
        
        /*
        let evalValue = determineIfFirstTimeLaunch()
        
        // Case if program is being used for the first time.
            if(evalValue == true){
              
                
                // 1 - WSDM creates a user setting profile.
                
                    // 1.1 - Creates user setting object for "User Attr" entity.
                        singleton.coreDataObject.addEntityObject("User_Attr", nameOfKey: "serialPortPath", nameOfObject: "Blank")
                
                // 2 - WSDM launches the "Edit User Settings" window to allow the user to specify which port they want to use by default.
                    launchWindowManager(self)
            }
            
        // Case if program has been used before.
            else{
                // - 1 WSDM loads the preferred serial port into the singleton:
                    singleton.serialPortObject = SerialPortManager(pathName: singleton.serialPath ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
            }*/
    }
 
    
    
}
