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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func executeScript(sender:Any){
        print("executing script");
    }

}

