//
//  ViewController.swift
//  testApp
//
//  Created by Osa on 8/25/16.
//  Copyright © 2016 Osa. All rights reserved.
//


//Links that helped:
//http://stackoverflow.com/questions/25456359/how-to-get-data-out-of-bluetooth-characteristic-in-swift
//http://stackoverflow.com/questions/24023253/how-to-initialise-a-string-from-nsdata-in-swift
//http://www.rfduino.com/wp-content/uploads/2014/03/rfduino.ble_.programming.reference.pdf
//http://stackoverflow.com/questions/28866935/nsdata-to-string-in-swift-issues
//https://evothings.com/forum/viewtopic.php?t=102
//http://anasimtiaz.com/?p=201
//http://forum.rfduino.com/index.php?topic=727.30


import Cocoa
import CoreBluetooth


class ViewController: NSViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager: CBCentralManager!
    var thePeripheral: CBPeripheral!
    
    // The UUIDs
    let connectServiceUUID = CBUUID(string: "2220")
    let receiveServiceUUID = CBUUID(string: "2221")
    let sendServiceUUID = CBUUID(string: "2222")
    let disconnectServiceUUID = CBUUID(string: "2223")
    
    
    
    
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    
    func bytes2String(array:[UInt16]) -> String {
        return String(data: NSData(bytes: array, length: array.count), encoding: NSUTF8StringEncoding) ?? ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Set up title label
        titleLabel.stringValue = "Item"
        titleLabel.sizeToFit()
        // Set up status label
        statusLabel.stringValue = "Item"
        statusLabel.sizeToFit()
        // Set up temperature label
        secondLabel.stringValue = "Item"
        secondLabel.sizeToFit()
        
        
        let testBytes : [UInt8] = [0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x57, 0x6F, 0x72, 0x6C, 0x64]
        //print( bytes2String(testBytes) )
        
        print("Loaded.")
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    // Check status of BLE hardware
    /*
     
     This is done using  centralManagerDidUpdateState delegate method. If the state of CBCentralManager object is PoweredOn we will start scanning for peripheral devices and update the statusLabel text to show the same. The CBCentralManager state can be PoweredOff or Unknown or even Unsupported so feel free to have a different error message for each if you need.
     
     */
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        if central.state == CBCentralManagerState.PoweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripheralsWithServices(nil, options: nil)
            self.statusLabel.stringValue = "Searching for BLE Devices"
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            print("Bluetooth switched off or not initialized")
        }
    }
    
    
    // Discovering Peripherals To Find RFDuino
    /*
     
    Now we check the advertisement data of each peripheral that the central manager finds. This is done using the didDiscoverPeripheral delegate method which gets called for every peripheral found. Implement the method as below.
     
     */
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        
        let deviceName = "RFDuino"
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? NSString
        
        if (nameOfDeviceFound == deviceName) {
            // Update Status Label
            self.statusLabel.stringValue = "RFDuino Found"
            
            // Stop scanning
            self.centralManager.stopScan()
            // Set as the peripheral to use and establish connection
            self.thePeripheral = peripheral
            self.thePeripheral.delegate = self
            self.centralManager.connectPeripheral(peripheral, options: nil)
        }
        else {
            self.statusLabel.stringValue = "RFDuino NOT Found"
        }
    }
   
    
    /* Connection to a Peripheral */
    /*
     
     The delegate method didConnectPeripheral gets called when a successful connection with the peripheral is established. On connection, we will call the peripheral method discoverServices() and update the statusLabel text as shown below.
     
     */
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        self.statusLabel.stringValue = "Discovering peripheral services"
        peripheral.discoverServices(nil)
    }
    
    
    
    /*  Discovering Peripheral Services  */
    /*
     
     The services of a peripheral can be identified by their UUIDs. The UUID of each service of the peripheral will be checked and compared. When the service is found, we will explore its chracteristics.
     
     */
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        self.statusLabel.stringValue = "Looking at peripheral services"
        for service in peripheral.services! {
            let thisService = service as CBService
            
            ///*
            if service.UUID == connectServiceUUID {
                // Discover characteristics of IR Temperature Service
                print("Connect service detected.")
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            else if service.UUID == receiveServiceUUID{
                print("Receive service detected.")
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            else if service.UUID == sendServiceUUID{
                print("Send service detected.")
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            else if service.UUID == disconnectServiceUUID{
                print("Disconnect service detected.")
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            else{
                print("No service detected.")
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            //*/
            
            // Uncomment to print list of UUIDs
            //print(thisService.UUID)
        }
    }
    
    /* Discovering Characteristics and Enabling Sensor */
    /*
     Implements the delegate for didDiscoverCharacteristicsForService
     */
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        
        // update status label
        self.statusLabel.stringValue = "Enabling sensors"
        
        // 0x01 data byte to enable sensor
        var enableValue = 1
        let enablyBytes = NSData(bytes: &enableValue, length: sizeof(UInt8))
        
        // check the uuid of each characteristic to find config and data characteristics
        for charateristic in service.characteristics! {
            ///*
            let thisCharacteristic = charateristic as CBCharacteristic
            print(thisCharacteristic)
            // check for data characteristic
            //if thisCharacteristic.UUID ==  0x608000085a50 {
                // Enable Sensor Notification
                print("Enabling sensor notification.")
                self.thePeripheral.setNotifyValue(true, forCharacteristic: thisCharacteristic)
           // }
            // check for config characteristic
           /* if thisCharacteristic.UUID == IRTemperatureConfigUUID {
                // Enable Sensor
                self.sensorTagPeripheral.writeValue(enablyBytes, forCharacteristic: thisCharacteristic, type: CBCharacteristicWriteType.WithResponse)
            }
            */
        }
        
    }
    
    
    /* Getting Data Values from the Sensor */
    /*
     After subscribing to RFDuino notifications(for data characteristic) the didUpdate ValueForCharacteristic delegate method gets callled every time we have to read a value from the sensor.
     */
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
        self.statusLabel.stringValue = "Connected"
       
        ///*
        if characteristic.UUID == receiveServiceUUID {
            // Convert NSData to array of signed 16 bit values
            
            /*
            var data = characteristic.value
            var values = [UInt8](count:data!.length, repeatedValue:0)
            print(values)
            print(data)
            print("Hello.")
 */
            /*
            var datastring = NSString(data: characteristic.value!, encoding: NSUTF8StringEncoding)
            data!.getBytes(&datastring, length:data!.length)
            
            print(datastring)
            
            let sval = NSString(data: characteristic.value!, encoding: NSUTF8StringEncoding)
            print(sval)
            */
            
            
            
            let dataBytes = characteristic.value
            let dataLength = dataBytes!.length
            var dataArray = [UInt16](count: dataLength, repeatedValue: 0)
            dataBytes!.getBytes(&dataArray, length: dataLength * sizeof(UInt16))
            print(bytes2String(dataArray))
            /*print("Value:")
            print(dataArray)
            
            
            */
            //let value = NSString(format: )
            
            //let value = NSString(dataArray)
            // Element 1 of the array will be ambient temperature raw value
            //et ambientTemperature = Double(dataArray[1])
            //print(ambientTemperature)
            // Display on the temp label
            //let value = NSString(format: "%.2f", ambientTemperature)
            //print(value)
            //print(dataArray as String)
        }
        //*/
    }

    
    
    /* Disconnection From a Peripheral */
    /*
     This is a very simple method and all it does is that when RFDuio is disonnected, it updates
     the status label to say that it is the case and then starts to scan again for RFDuinos.
     */
    
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        self.statusLabel.stringValue = "Disconnected"
        central.scanForPeripheralsWithServices(nil, options: nil)
    }
}

