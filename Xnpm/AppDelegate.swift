//
//  AppDelegate.swift
//  Xnpm
//
//  Created by Joss Manger on 6/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var projects:Array<String>?
    var listView:ListProtocol?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
      
       
        
//        if #available(OSX 10.12.2, *) {
//            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func handleOpen(url:URL){
        let package = PackageAnalyser(packageUrl: url)
        let main = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "MainWindow") as! NSWindowController
        let mainVc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as! ViewController
        mainVc.package = package
        main.window?.title = "Xnpm - "+package.packageTitle
        main.window?.contentViewController = mainVc
        main.window?.makeKeyAndOrderFront(nil)
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let url = URL(fileURLWithPath: filename)
        handleOpen(url: url)
        return true
    }
    
    func checkandAddToDefaults(url:URL){
        var projects = UserDefaults.standard.array(forKey: "projects") as? Array<String>
        var match:Bool = false;
        if let areProjects = projects{
            for u in areProjects.enumerated(){
                if(url.absoluteString == u.element){
                    match = true;
                }
            }
        }
        if(!match){
            var array = projects
            array?.append(url.absoluteString)
            let immutableArray = NSArray(array: array!)
            print(immutableArray)
            UserDefaults.standard.set(immutableArray, forKey: "projects")
            UserDefaults.standard.synchronize()
            listView?.updateNotify()
        }

    }
    
    func addToDefaults(url:URL){
        
    }
    
    @IBAction func openAction(_ sender: Any) {
        
        print("open called")
        
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["json"];
        openPanel.canChooseDirectories = false;
        
        openPanel.begin(completionHandler: {
            number in
            if(openPanel.url!.pathComponents.last == "package.json"){
                NSDocumentController.shared().noteNewRecentDocumentURL(openPanel.url!)
                self.checkandAddToDefaults(url: openPanel.url!)
                self.handleOpen(url: openPanel.url!)
            } else {
                let alert = NSAlert()
                alert.alertStyle = .critical
                alert.messageText = "\(openPanel.url!) is not a valid npm package manifest (package.json)"
                alert.runModal()
            }
            
        })
    }
    
    
    
}

