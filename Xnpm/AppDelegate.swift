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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if #available(OSX 10.12.2, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        } else {
            // Fallback on earlier versions
        }
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
    
    @IBAction func openAction(_ sender: Any) {
        
        print("open called")
        
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["json"];
        openPanel.canChooseDirectories = false;
        
        openPanel.begin(completionHandler: {
                number in
            if(openPanel.url!.pathComponents.last == "package.json"){
                NSDocumentController.shared().noteNewRecentDocumentURL(openPanel.url!)
                self.handleOpen(url: openPanel.url!)
            } else {
                print("error, not a package // should be alertdialog here")
            }
            
        })
    }
    
    

}

