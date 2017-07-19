//
//  ListViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 7/17/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ListViewController: NSViewController,NSTableViewDelegate, ListProtocol{
    
    @IBOutlet weak var table: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var OpenButton: NSButton!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var removeButton: NSButton!
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
    
    override func keyDown(with event: NSEvent) {
        if(event.keyCode==117||event.keyCode==51){
            print("delete key pressed on \(table.selectedRow)");
            deleteProjectAndUpdate(nil)
        }
    }
    
    func loadDefaults(){
        
        projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        let mutable = NSMutableArray()
        for path in projects!{
            
            let currentIndex = PackageAnalyser(packageUrl: URL(string: path))
            mutable.add(currentIndex)
            
        }
        
        arrayController.content = mutable
        arrayController.setSelectionIndex(table.selectedRow)
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
    
    
    @IBAction func deleteProjectAndUpdate(_ sender: Any?){
        let deleteIndex = arrayController.selectionIndex;
        projects!.remove(at: deleteIndex)
        print(projects!)
        UserDefaults.standard.set(projects, forKey: "projects")
        UserDefaults.standard.synchronize()
        loadDefaults()
    }
    
    @IBAction func addProject(_ sender: Any) {
        appDelegate.openAction(self.view.window as Any)
    }
    @IBAction func open(_ sender: Any) {
        //fires when clicking anywhere in table, fix
        if(table.selectedRow != -1){
            let url = URL(string:projects![table.selectedRow])!
            print(sender)
            appDelegate.handleOpen(url: url)
        }

        
    }
    
}
