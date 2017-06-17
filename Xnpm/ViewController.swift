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
    @IBOutlet weak var scriptDropdown: NSPopUpButton!
    @IBOutlet weak var execButton: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var runButton: NSButton!
    
    var package:PackageAnalyser!{
        didSet{
            print("didset")
            print(package.returndict())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        self.view.window?.unbind(#keyPath(touchBar)) // unbind first
        self.view.window?.bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func runFromTouchBar(_ sender: Any) {
        executeScript(sender: sender)
    }

    @IBAction func executeScript(sender:Any){
        print("executing script from \((sender as! NSButton).title)");
    }

    deinit {
        self.view.window?.unbind(#keyPath(touchBar))
    }
    
}

