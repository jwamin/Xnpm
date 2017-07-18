//
//  ListViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 7/17/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ListViewController: NSViewController,NSTableViewDelegate, ListProtocol {
    
    @IBOutlet weak var table: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var OpenButton: NSButton!
    @IBOutlet weak var addButton: NSButton!
    var projects:Array<String>?
    var appDelegate:AppDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        
    }
    
    override func awakeFromNib() {
        table.target = self;
        table.doubleAction = #selector(rowDoubleClick)
    }
    
    override func viewWillAppear() {
        appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.listView = self
        loadDefaults()
    }
    
    func rowDoubleClick(){
        open(self)
    }
    
    func loadDefaults(){
        projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        print(projects!.count)
        let mutable = NSMutableArray()
        for path in projects!{
            
            let currentIndex = PackageAnalyser(packageUrl: URL(string: path))
            mutable.add(currentIndex)
            
        }
        arrayController.content = mutable
    }
    
    func updateNotify() {
        print("got update notification")
        loadDefaults()
    }
    
    //    func numberOfRows(in tableView: NSTableView) -> Int {
    //        return projects?.count ?? 0
    //    }
    
    //    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
    //
    //        if let path = projects?[row]{
    //            print(path,URL(fileURLWithPath: path))
    //            let currentIndex = PackageAnalyser(packageUrl: URL(string: path))
    //
    //            if(tableColumn?.title == "Project Name"){
    //                print(currentIndex.packageTitle)
    //                return currentIndex.packageTitle
    //            } else if (tableColumn?.title == "Path"){
    //                return currentIndex.url
    //            }
    //
    //        }
    //        return "nil"
    //    }
    
    //    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
    //        print(rowView,row)
    //    }
    
    
    func tableViewSelectionDidChange(_ notification: Notification) {
       
        if (table.selectedRow != -1){
            OpenButton.isEnabled = true;
        } else {
            OpenButton.isEnabled = false;
        }
        
    }
    
    @IBAction func addProject(_ sender: Any) {
        appDelegate.openAction(self.view.window)
    }
    @IBAction func open(_ sender: Any) {
        
        let url = URL(string:projects![table.selectedRow])!
        print(sender)
        appDelegate.handleOpen(url: url)
        
    }
    
}
