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
        var selectedWS:String!
    var canAssociateVar = false
    
    
    
    var rfidValue:String!
    
    var openedWD: String!
        //var serialPort:String!
        //var filePath:String!
    var filePath:String {
        get{
            return userPrefObject.get_fileDirectory(&coreDataObject)
        }
    }
    //var serialPath:String! = nil
    var serialPath:String {
        get{
            return userPrefObject.get_serialPort(&coreDataObject)
        }
    }
    /*
    /*Set Functions*/
    
        func setSelectedWS(incoming_selectedWS:String){
            //userPrefObject.set_fileDirectory(&<#T##coreDataObject: dataCore##dataCore#>, filePath: <#T##String#>)
            selectedWS=incoming_selectedWS
        }
    
        func setSerialPort(incoming_serialPort:String){
                serialPort=incoming_serialPort
            
        }
            
        func setFilePath(incoming_filePath:String){
                filePath = incoming_filePath
        }
    
    /*Get Functions*/
        func getSelectedWS()->String{
            return selectedWS
        }
    
        func getSerialPort()->String{
            return serialPort
        }
        
        func getFilePath()->String{
            return filePath
        }
    */
    
}
