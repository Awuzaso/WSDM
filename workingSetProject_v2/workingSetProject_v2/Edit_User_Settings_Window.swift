//
//  Edit_User_Settings_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Edit_User_Settings_Window: NSViewController {
    //let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    //let userPref = UserPrefManager()
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    
    var selectedIndex:Int!
    var port:String!
    var portPath:String!
    var dataCore = singleton.coreDataObject
    
    @IBOutlet weak var File_Directory_Label: NSTextField!
    
    
    @IBOutlet weak var Serial_Port_Label: NSPopUpButton!
    
    
    func setDefaultPref(){
        // - 1 Initialize values to set "userPrefObject".
        port = Serial_Port_Label.itemTitleAtIndex(0)
        portPath = "/dev/cu."+port
        
        // - 2 Set to objects.
        //singleton.userPrefObject.set_fileDirectory(&dataCore, filePath: File_Directory_Label.stringValue)
        singleton.userPrefObject.set_serialPort(&dataCore, portPath: portPath)
        
        
        // - 3 Reset serial port and commit changes.
        singleton.serialPortObject = SerialPortManager(pathName: portPath ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultPref()
    }
    
    
    
    @IBAction func OpenWindowForDirectory_Button(sender: AnyObject) {

        
    }
  
    
    @IBAction func OK_Button(sender: AnyObject) {
        print("Press")
        //Save user changes here. Close window.
        
        ///*
        //var dataCore = singleton.coreDataObject
     
        selectedIndex = Serial_Port_Label.indexOfSelectedItem
        port = Serial_Port_Label.itemTitleAtIndex(selectedIndex)
        portPath = "/dev/cu."+port
        //print(portPath)
        //singleton.userPrefObject.set_fileDirectory(&dataCore, filePath: File_Directory_Label.stringValue)
        singleton.userPrefObject.set_serialPort(&dataCore, portPath: portPath)
        
        singleton.serialPortObject = SerialPortManager(pathName: portPath ,in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
        //Test if it works:
        //print(singleton.coreDataObject.getSingleObjectAttrib("User_Attr", nameOfKey: "pathToSaveWS"))
        print(singleton.coreDataObject.getSingleObjectAttrib("User_Attr", nameOfKey: "serialPortPath"))
        
        singleton.openWindowObject.stopEvents()
        //let application = NSApplication.sharedApplication()
        //application.stopModal()
        //*/
    }
    
    
    
    @IBAction func Cancel_Button(sender: AnyObject) {
        
         singleton.openWindowObject.stopEvents()
        
        
    }
    
    
    
    
}
