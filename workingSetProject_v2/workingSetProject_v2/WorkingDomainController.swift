//
//  WorkingDomainController.swift
//  workingSetProject_v2
//
//  Created by Osa on 7/5/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class WorkingDomainController: NSViewController {
    
 
    
    var loadedWDName = "Value"
    var wdAccDate:NSDate!
    
    
    
    @IBOutlet weak var tableViewWD: NSTableView!
    @IBOutlet weak var nameOfWD: NSTextField!
    @IBOutlet weak var associateToCardState: NSTextField!
    @IBOutlet weak var directoryPath: NSTextField!
    
    
    
    
    
    
    /*Variables*/
    //var nameOfWS = "Stuff" //Selected WS
    var selectedFile:String!
    var contentsOfWD = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    /*Variables for Sorting Table View*/
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true

    
    func setupTableView(){
        tableViewWD!.setDelegate(self)
        tableViewWD!.setDataSource(self)
        tableViewWD!.target = self
        tableViewWD.doubleAction = "tableViewDoubleClick:"
        
        
        
           NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveNameChange_Button:",name:"updateWD", object: nil)
           NSNotificationCenter.defaultCenter().addObserver(self, selector: "rmvFile",name:"remove", object: nil)
    }
    
    

    /*Set-up View*/
    override func viewDidLoad() {
        super.viewDidLoad()
        print("The value is now: \(singleton.openedWD)")
        nameOfWD.stringValue = singleton.openedWD
        loadedWDName = nameOfWD.stringValue
        setupTableView()
        
    }

    override func awakeFromNib() {
        
    }
    
    func rmvFile(){
        singleton.coreDataObject.deleteEntityObject("File", nameOfKey: "nameOfFile", nameOfObject: selectedFile)
        
        self.reloadFileList()
        
    }
    
   
    
    
    @IBAction func saveNameChange_Button(sender: AnyObject) {
        singleton.coreDataObject.editEntityObject("WorkingDomain", nameOfKey: "nameOfWD", oldName: loadedWDName, editName: nameOfWD.stringValue)
        loadedWDName = nameOfWD.stringValue
        singleton.openedWD = loadedWDName
        NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil)
        self.reloadFileList()
        print("Saved!")
    }
    
    
    
    @IBAction func removeFile_Button(sender: AnyObject) {
        
        singleton.openWindowObject.setWindow("Main", nameOfWindowController: "removeFileWindow")
        singleton.openWindowObject.runModalWindow()
        //self.removeSelectedFile()
    }
    
    
    
    
    func updateTableViewWD(){
        self.reloadFileList()
    }
    
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
        tableViewWD!.reloadData()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            reloadFileList()
        }
    }
}
