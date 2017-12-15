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
    
    
    
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let identifiers:[NSTouchBarItemIdentifier] = [.icon,.label,.button,.scriptButton]
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .XnpmTouchBar
        touchBar.defaultItemIdentifiers = identifiers //[.icon,.label, .fixedSpaceLarge, .otherItemsProxy]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
        case NSTouchBarItemIdentifier.label:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField.init(labelWithString: "Xnpm "+package.packageTitle)
            custom.view = label
            
            return custom
        case NSTouchBarItemIdentifier.icon:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let img = NSApp.applicationIconImage!
            img.size = CGSize(width: 30.0, height: 30.0)
            let imgview = NSImageView(image: img)
            imgview.frame.size = CGSize(width: imgview.frame.width, height: 30.0)
            imgview.imageScaling = .scaleProportionallyUpOrDown
            custom.view = imgview
            print("something")
            return custom
        case NSTouchBarItemIdentifier.button:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            var image = NSImage(named: NSImageNameTouchBarPlayTemplate)!
            if(taskRunning){
                image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)!
            }
            let button = NSButton(image: image, target: self, action: #selector(executeScript(sender:)))
            buttonItem.view = button
            return buttonItem
        case NSTouchBarItemIdentifier.scriptButton:
            let buttonItem = NSPopoverTouchBarItem(identifier: .scriptButton)
            //buttonItem.showsCloseButton = true
            buttonItem.collapsedRepresentationLabel = "Script: \(scriptDropdown.selectedItem!.title)"
            buttonItem.popoverTouchBar = ScriptsPopover(self.scriptDropdown,self) as ScriptsPopover
            return buttonItem
        default:
            return nil
        }
        
    }
    
    func updateScriptButton(){
        guard let touchBar = touchBar else { return }
        print("got touchbar")
        for itemIdentifier in touchBar.itemIdentifiers {
            guard let item = touchBar.item(forIdentifier: itemIdentifier) as? NSPopoverTouchBarItem else {continue}
            
            if(itemIdentifier == NSTouchBarItemIdentifier.scriptButton){
                print("got here")
                item.collapsedRepresentationLabel = "Script: \(scriptDropdown.selectedItem!.title)"
            }
            
        }
    }
    
    
    func customizeActionButton(_ isrunning:Bool){
        
        guard let touchBar = touchBar else { return }
        print("got touchbar")
        for itemIdentifier in touchBar.itemIdentifiers {
            guard let item = touchBar.item(forIdentifier: itemIdentifier) as? NSCustomTouchBarItem,
                let button = item.view as? NSButton else {continue}
            
            if(itemIdentifier == NSTouchBarItemIdentifier.button){
                print("got here")
                
                var image = NSImage(named: NSImageNameTouchBarPlayTemplate)!
                if(isrunning){
                    image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)!
                }
                
                button.image = image
            }
            
        }
    }
    
    
}

