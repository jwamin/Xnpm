//
//  ViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa
import SwiftGit2


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
    @IBOutlet weak var branch: NSTextField!
    
    var consoleWindow:NSWindow?
    var consoleViewController:ConsoleViewController?
    var taskC:TaskController?
    var taskRunning:Bool = false;
    
    var gitThingy:Repository!
    
    var package:PackageAnalyser!{
        didSet{
            print("Xnpm "+package.packageTitle)
        }
    }
    
    
    
    
    @IBAction func changed(_ sender: Any) {
        if #available(OSX 10.12.2, *) {
            updateScriptButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.view.window?.title = "Xnpm "+package.packageTitle
        
        
 
        

        
        
    }
    
    
    override func viewDidAppear() {
        
        if #available(OSX 10.12.2, *) {
            self.view.window?.unbind(#keyPath(touchBar)) // unbind first
            self.view.window?.bind(#keyPath(touchBar), to: self, withKeyPath: #keyPath(touchBar), options: nil)
        }
        

    getBranch()
        
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
            if #available(OSX 10.12.2, *) {
                customizeActionButton(taskRunning)
            }
            
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
        changed(self)
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
        if #available(OSX 10.12.2, *) {
            customizeActionButton(taskRunning)
        }
        
        scriptDropdown.isEnabled = true;
        
        
        activity.stopAnimation(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "gotEnd"), object: nil)
    }
    
    
    
    deinit {
        if #available(OSX 10.12.2, *) {
            self.view.window?.unbind(#keyPath(touchBar))
        }
    }
    
    
    //Git Branch functionality
    
    func getBranch()->Void{
        guard let url = package.url else {
            return
        }
        
        let str = NSString(string: url.absoluteString)
        let path = str.deletingLastPathComponent
        let finalURL = URL(string: path)!
    
        let repo = Repository.at(finalURL)
        if let repo = repo.value{
            let currentBranch = repo.HEAD()
            if let branch = currentBranch.value {
                if let branchname = branch.shortName{
                    self.package.setBranch(branchString: branchname)
                }
                
            }
            
        }
    }
    
    
}

