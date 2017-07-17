//
//  ListViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 7/17/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ListViewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource,ListProtocol {

    @IBOutlet weak var table: NSTableView!
    var projects:Array<String>?
    var appDelegate:AppDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.listView = self
        loadDefaults()
    }
    
    func loadDefaults(){
        projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        print(projects)
    }
    
    func updateNotify() {
        print("got update notification")
        loadDefaults()
        table.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return projects?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        if let path = projects?[row]{
            print(path,URL(fileURLWithPath: path))
            let currentIndex = PackageAnalyser(packageUrl: URL(string: path))
            
            if(tableColumn?.title == "Project Name"){
                print(currentIndex.packageTitle)
                return currentIndex.packageTitle
            } else if (tableColumn?.title == "Path"){
                return currentIndex.url
            }

        }
        return "nil"
    }
    
    
    @IBAction func open(_ sender: Any) {
       
        let url = URL(string:projects![table.selectedRow])!
        print(url)
        appDelegate.handleOpen(url: url)
        
    }
    
}
