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
    @IBOutlet weak var activity: NSProgressIndicator!
    
    var consoleWindow:NSWindow?
    var consoleViewController:ConsoleViewController?
    var taskC:TaskController?
    var taskRunning:Bool = false;
    
    
    var package:PackageAnalyser!{
        didSet{
            print("Xnpm "+package.packageTitle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(OSX 10.12.2, *) {
            bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        }
        
        // Do any additional setup after loading the view.
        self.view.window?.title = "Xnpm "+package.packageTitle
        
        
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
    
    @IBAction func executeScript(sender:Any){

        if !taskRunning {
            if let availableConsoleWindow = consoleWindow{
                availableConsoleWindow.makeKeyAndOrderFront(self)
            } else {
                self.performSegue(withIdentifier: "showConsole", sender: self)
                consoleWindow = NSApplication.shared().windows[1]
                consoleWindow?.title = package.packageTitle + " Console"
                if let vc = consoleWindow?.contentViewController{
                    consoleViewController = vc as? ConsoleViewController
                }
            }
            activity.startAnimation(self)
            taskC = TaskController(url: package.url)
            let selectedCommand = scriptDropdown.selectedItem!.title
            taskRunning = true;
            scriptDropdown.isEnabled = false;
            taskC?.beginTask(selectedCommand)
            execButton.title = "Halt"
        } else {
            execButton.title = "Execute"
            taskC?.endTask()
            taskC = nil
            taskRunning = false
            scriptDropdown.isEnabled = true;
            consoleWindow?.close()
            consoleWindow = nil
            activity.stopAnimation(self)
        }

        
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
