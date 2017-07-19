//
//  ViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSWindowDelegate {
    
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
        
        //        if #available(OSX 10.12.2, *) {
        //            bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        //        }
        
        // Do any additional setup after loading the view.
        self.view.window?.title = "Xnpm "+package.packageTitle
        
        
    }
    
    
    override func viewDidAppear() {
        
        self.view.window?.delegate = self
        
        if #available(OSX 10.12.2, *) {
            self.view.window?.unbind(#keyPath(touchBar)) // unbind first
            self.view.window?.bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        }
    }
    
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func windowDidBecomeKey(_ notification: Notification) {
       
        package.processPackage()
    }
    
    @IBAction func executeScript(sender:Any){
        package.processPackage()
        if !taskRunning {
            if let availableConsoleWindow = consoleWindow{
                availableConsoleWindow.makeKeyAndOrderFront(self)
            } else {
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                print(storyboard)
                let windowController = storyboard.instantiateController(withIdentifier: "ConsoleViewWindow") as! WindowController
                print(windowController)
                consoleWindow = windowController.window!// this is the dodgy bit, gets window in list, rather than specific, correct window
                consoleWindow?.title = package.packageTitle + " Console"
                if let vc = consoleWindow?.contentViewController{
                    consoleViewController = vc as? ConsoleViewController
                    consoleViewController?.parentController = self
                    print(vc)
                    windowController.showWindow(self)
                }
            }
            activity.startAnimation(self)
            taskC = TaskController(url: package.url!, withIdentifier: package.packageTitle)
            let selectedCommand = scriptDropdown.selectedItem!.title
            taskRunning = true;
            scriptDropdown.isEnabled = false;
            taskC?.beginTask(selectedCommand)
            execButton.title = "Halt"
            NotificationCenter.default.addObserver(self, selector: #selector(executeScript), name: NSNotification.Name(rawValue: "gotEnd"), object: nil)
        } else {
            
            guard let notification = sender as? NSNotification else {
                print("not a notification")
                closeProcess()
                return
            }
            
            let message = notification.object as! String
            if (message==package.packageTitle){
                closeProcess()
            }
            
        }
        
        
    }
    @IBAction func refresh(_ sender: Any) {
        
        package.processPackage()
        
    }
    @IBAction func editInExternalEditor(_ sender: Any) {
        NSWorkspace.shared().open(package.url)
    }
    
    private func closeProcess(){
        if let consoleWindowOpen = consoleWindow{
            consoleWindowOpen.close()
            consoleWindow = nil
        }

        
        execButton.title = "Execute"
        taskC?.endTask()
        taskC = nil
        taskRunning = false
        scriptDropdown.isEnabled = true;
        
        
        activity.stopAnimation(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "gotEnd"), object: nil)
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
