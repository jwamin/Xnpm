//
//  ViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mainTitle: NSTextField!
    @IBOutlet weak var author: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var license: NSTextField!
    @IBOutlet weak var repoLink: NSTextField!
    @IBOutlet var scriptDropdown: NSPopUpButton!
    @IBOutlet weak var execButton: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var runButton: NSButton!
    
    var package:PackageAnalyser!{
        didSet{
            print("didset")
            //print(package.returndict())
            //populateDropdown()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(OSX 10.12.2, *) {
            bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        }
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear() {
        self.view.window?.unbind(#keyPath(touchBar)) // unbind first
        self.view.window?.bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
    }
    
    func populateDropdown(){

        scriptDropdown!.removeAllItems()
        let main = package.returndict() as [String:Any]
        let dict = main["scripts"] as! [String:String]
        let scripts = Array(dict.keys)

        scriptDropdown!.addItems(withTitles: scripts)
        scriptDropdown.isEnabled = true;
        
//        Update Touch Bar, if available
//        if #available(OSX 10.12.2, *) {
//            for key in scripts {
//                
//                touchBar
//            }
//        
//        }
        
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func executeScript(sender:Any){
        print("executing script from \((sender as! NSButton).title)");
    }

    deinit {
        if #available(OSX 10.12.2, *) {
        self.view.window?.unbind(#keyPath(touchBar))
        }
    }
    
}

//@available(OSX 10.12.2, *)
//extension ViewController: NSTouchBarDelegate{
//
// 
//    
//}
