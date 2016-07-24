//
//  Serial_Port_Manager_Class.swift
//  test
//
//  Created by Osa on 6/24/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


var stringVar:String!

class SerialPortManager:NSObject,ORSSerialPortDelegate{
    
    var oldStringVal: NSString = "OldValue"
    
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    
    
    var serialPort: ORSSerialPort!
   
    // MARK: - Modal Window Variables
    
    var nameOfStoryboard: String!
    
    var nameOfWindowIfUnassociated: String!
    
    var nameOfWindowIfAssociated: String!
    
    //var windowController : NSWindowController?
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    init(pathName:String,in_nameOfStoryBoard: String, in_nameOfWinUnAssoc:String, in_nameOfWinAssoc:String){
        super.init()
        
        nameOfStoryboard = in_nameOfStoryBoard
        nameOfWindowIfAssociated = in_nameOfWinAssoc
        nameOfWindowIfUnassociated = in_nameOfWinUnAssoc
        print(pathName)
        let pathNameBlue = "/dev/cu.LightBlue-Bean"
        print( pathNameBlue )
        //print( serialPortManager.availablePorts )
        
        serialPort = ORSSerialPort(path: "\(pathName)")
        serialPort?.delegate = self
        serialPort!.baudRate = 115200
        serialPort!.numberOfStopBits = 2
        
        serialPort!.open()
       
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func get_SerialPorts()->Array<String>{
        var arrayOfPorts_string:[String]!
        var arrayOfPorts = serialPortManager.availablePorts
        
       
        
        for(var i = 0; i < arrayOfPorts.count; i += 1){
            print(arrayOfPorts[i])
            let value = "\(arrayOfPorts[i])"
            
            arrayOfPorts_string[i] = value
        }
        
        
  
        return arrayOfPorts_string
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func launchWindow(nameOfWindow:String){
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let openWindowController = storyboard.instantiateControllerWithIdentifier(nameOfWindow) as! NSWindowController
        ///*
        // 2
        if let openModalWindow = openWindowController.window{
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openModalWindow)
            
        }
        //*/
        
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func giveIDtoAppDelegate(cardValue:String){
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.set_CardValue(cardValue)
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func evaluateIfCardIsInDataBase(cardValue:String)->Bool{
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        let dataCore = singleton.coreDataObject
        let in_cardValue = cardValue
        
        let retVal = dataCore.evaluateIfInDB("WorkingDomain", nameOfKey: "tagID", nameOfObject: in_cardValue)
        
        return retVal
    }

    // MARK: - ORSSerialPortDelegate
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasOpened(serialPort: ORSSerialPort) {
        print("Open!")
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasClosed(serialPort: ORSSerialPort) {
        print("Closed!")
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPort(serialPort: ORSSerialPort, didReceiveData data: NSData) {
            // - 1
            print("Active...")
            // -2
        
       
        
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                // -3
                var oldStringVal = string
                //print(string)
                
                    if((string.length == 21)  /*&& (string != oldStringVal)*/ ){
                    
                    
                    
                    
                    
                    stringVar = string as String
                    
                    // -4
                    oldStringVal = string
                    let sendVal = (string as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    
                    
                    
                    //giveIDtoAppDelegate(sendVal)
                    singleton.rfidValue = sendVal
                    
                    print( singleton.rfidValue )
                    
                    
                    
                    
                    
                    let eval = evaluateIfCardIsInDataBase(sendVal)
                    
                    
                    print("It is \(eval) that the card is in the database.")
                    if( eval == false){
                        print("Unassociated")
                        //launchWindow(nameOfWindowIfUnassociated)
                        
                        // 1 - Setting window object.
                        let openWindowObject = windowManager()
                        openWindowObject.setWindow("Main",nameOfWindowController: "UAWindow"/*nameOfWindowIfUnassociated*/)
                        // 2 - Initiate the window.
                        openWindowObject.runModalWindow()
                        
                        
                        /*
                        // 1 - Setting window object.
                        
                        openWindowObject.setWindow("Main",nameOfWindowController: "WorkingDomainManager")
                        // 2 - Setting the values of the window object.
                        let openWindowController = openWindowObject.get_windowController()
                        let openWindowViewController = openWindowController.contentViewController as! workingSetManagerViewController
                        openWindowViewController.switchOnOffButtons(true, deleteActive: true, associateActive: true)
                        openWindowViewController.awakeFromNib()
                        */
                        
                    NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                        
                        
                        
                        

                        
                    }
                    else if( eval == true){
                        print("Associated")
                        
                        print("Check out:")
                        singleton.openedWD = singleton.coreDataObject.getValueOfEntityObject("WorkingDomain",  idKey:"tagID", nameOfKey:"nameOfWD",nameOfObject: singleton.rfidValue)
                        
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("associateWindow", object: nil)
                        print("Do it.")
                        
                    }
                    
                }
            }
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasRemovedFromSystem(serialPort: ORSSerialPort) {
        print("Serial port, \(serialPort) was removed from the system.")
    }
    

    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPort(serialPort: ORSSerialPort, didEncounterError error: NSError) {
        print("Serial port, \(error) was removed from the system.")
        
    }
/*END OF CLASS*/

}
