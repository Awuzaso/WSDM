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
       let tpathName = "/dev/cu.Bluetooth-Incoming-Port"
        
        serialPort = ORSSerialPort(path: "\(pathName)")
        
        if( serialPort == nil ){
            print( "Not ready.")
            serialPort = ORSSerialPort(path: "\(tpathName)")
        }
        else{
            print("Ready.")
        }
        
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
    /*func giveIDtoAppDelegate(cardValue:String){
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.set_CardValue(cardValue)
    }
    */
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func evaluateIfCardIsInDataBase(cardValue:String)->Bool{
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        let dataCore = singleton.coreDataObject
        let in_cardValue = cardValue
        
        let retVal = dataCore.evaluateIfCardIsInDB("WorkingDomain", nameOfKey: "tagID", nameOfObject: in_cardValue)
        
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
                
                //Evaluate if read card is in "Card" entity.
                if (string.length == 21){
                    let sendVal = (string as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    let cardIsInDB = singleton.coreDataObject.evaluateIfCardIsInDB("Card", nameOfKey: "rfidValue", nameOfObject: sendVal)
                    print(cardIsInDB)
                    singleton.readCard = singleton.coreDataObject.getEntityObject("Card", idKey: "rfidValue", idName: sendVal)
                    print(singleton.readCard.valueForKey("rfidValue"))
                    singleton.canAssociateVar = true
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
