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
        
        
      
        //let file = singleton.coreDataObject.getEntityObject("WorkingDomain", idKey: "nameOfWD", idName: "Nausea")
        
        //let obj = file.valueForKey("associatedFiles")
        
        
        //print(  file.valueForKey("nameOfWD") )
        
        //Fetching all associated files of Nausea
        
            // Create Fetch Request
            //let fetchRequest = NSFetchRequest(entityName: "File")
            
            // Add Sort Descriptor
            //let sortDescriptor = NSSortDescriptor(key: "nameOfFile", ascending: true)
            //fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Execute Fetch Request
            /*do {
                let result = try singleton.coreDataObject.managedObjectContext.executeFetchRequest(fetchRequest)
                print("Files associated with Nausea:")
                print()
                let files = result as! [NSManagedObject]
                
                for managedObject in files {
                    
                    let assocWD = managedObject.valueForKey("associatedWD") as! NSMutableSet
                    let assocWDval =  assocWD.valueForKey("nameOfWD")
                   
                    //print(assocWDval)
                    
                  
                        if let first = managedObject.valueForKey("nameOfFile"), last = managedObject.valueForKey("nameOfPath") {
                            print("\(first)\n \(last)\n\(assocWDval)")
                        }
                  
                    
                    
                }
                
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }*/
        
        
        
        /*
        
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "WorkingDomain")
        
        // Create Predicate
        //let predicate = NSPredicate(format: "%K == %@", "associatedWD", "Nausea")
        //fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "nameOfFile", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "nameOfPath", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        var associatedObjects : [String] = []
        // Execute Fetch Request
        do {
            let result = try singleton.coreDataObject.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                let object = managedObject.mutableSetValueForKey("associatedFiles")
                /*if let first = managedObject.valueForKey("nameOfFile"), last = managedObject.valueForKey("nameOfPath"), age = managedObject.valueForKey("associatedWD") {
                    print("\(first) \(last) (\(age))")
                }*/
                //print("$$$$$$$$$$$$$$$$")
                //print(object.valueForKey("nameOfFile"))
                for i in object{
                    let item = i.valueForKey("nameOfFile") as! String
                    associatedObjects.append(item)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        print("/////////////////////")
        for i in associatedObjects{
            print(i)
        }
        print("/////////////////////")
        
        
        */
        
        
        //////
        
        
        
        
        
        
        //print( obj )
        
        //print ( obj?.valueForKey("nameOfFile") )
        
        print("Glip.")
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    
}

