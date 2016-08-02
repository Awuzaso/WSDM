//
//  workingSetSingleton_Class.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/5/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

let singleton = workingSetSingleton()

class workingSetSingleton {
    
    /*Establish Singleton*/
        static let sharedInstance = workingSetSingleton()
    
    /*Objects*/
        var coreDataObject = dataCore()
        var serialPortObject: SerialPortManager!
        let userPrefObject = UserPrefManager()
        let openWindowObject = windowManager()
    
    /*Frequently Used Variables*/
    
        // The currently selected 
        var selectedWS:String!
    
        // Bool variable that constrains actions on the basis if a card is present or not.
        var canAssociateVar = false
    
        // The rfidValue of the currently read card.
        var rfidValue:String!
    
        // The current card that is read.
        var readCard:NSManagedObject!
    
        // The name of the currently opened working domain.
        var openedWD: String!
    
        // Path to user's preferred file directory.
        var filePath:String {
            get{
                return userPrefObject.get_fileDirectory(&coreDataObject)
            }
        }
    
        //Path to user's prefferred serial port.
        var serialPath:String {
            get{
                return userPrefObject.get_serialPort(&coreDataObject)
            }
        }
    
}
