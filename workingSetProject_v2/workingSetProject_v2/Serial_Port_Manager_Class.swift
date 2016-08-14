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
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    init(pathName:String,in_nameOfStoryBoard: String, in_nameOfWinUnAssoc:String, in_nameOfWinAssoc:String){
        super.init()
        
        nameOfStoryboard = in_nameOfStoryBoard
        nameOfWindowIfAssociated = in_nameOfWinAssoc
        nameOfWindowIfUnassociated = in_nameOfWinUnAssoc
       let tpathName = "/dev/cu.Bluetooth-Incoming-Port"
        
        serialPort = ORSSerialPort(path: "\(pathName)")
        
        let descriptor = ORSSerialPacketDescriptor(prefixString: "_", suffixString: "\n" , maximumPacketLength: 34, userInfo: nil)
        //let descriptor = ORSSerialPacketDescriptor.init
        serialPort.startListeningForPacketsMatchingDescriptor(descriptor)
  
        
        if( serialPort == nil ){
            print( "Not ready.")
            serialPort = ORSSerialPort(path: "\(tpathName)")
        }
        else{
            print("Ready.")
        }
        
        serialPort?.delegate = self
        serialPort!.baudRate = 115200
        serialPort!.numberOfStopBits = 1
        
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
        
        // 2
        if let openModalWindow = openWindowController.window{
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openModalWindow)
            
        }
        
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
    func serialPort(serialPort: ORSSerialPort, didReceivePacket packetData: NSData, matchingDescriptor descriptor: ORSSerialPacketDescriptor) {
        if let string = NSString(data: packetData, encoding: NSUTF8StringEncoding) {
            
     
            print( string )
            
            
            
            let sendVal = (string as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            
            
            let cardIsInDB = singleton.coreDataObject.evaluateIfCardIsInDB("Card", nameOfKey: "rfidValue", nameOfObject: sendVal)
            
            if(cardIsInDB == false){
                singleton.openWindowObject.setWindow("Main", nameOfWindowController: "UAWindow")
                singleton.openWindowObject.runModalWindow()
                
            }
            else{
                
                singleton.readCard = singleton.coreDataObject.getEntityObject("Card", idKey: "rfidValue", idName: sendVal)
                singleton.canAssociateVar = true
                
                let associatedWD = singleton.readCard.valueForKey("associatedWD")
                
                let nameOfAssociatedWD = associatedWD?.valueForKey("nameOfWD")
                
                if(nameOfAssociatedWD != nil){
                    singleton.openedWD = associatedWD?.valueForKey("nameOfWD") as! String
                    NSNotificationCenter.defaultCenter().postNotificationName("associateWindow", object: nil)
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
