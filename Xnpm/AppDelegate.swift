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

    var dc:NSDocumentController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        dc = NSDocumentController()
        
        if #available(OSX 10.12.2, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        } else {
            // Fallback on earlier versions
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func openAction(_ sender: Any) {
        print("open called")
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["json"];
        openPanel.canChooseDirectories = false;
        openPanel.begin(completionHandler: {
                number in
                self.dc.noteNewRecentDocumentURL(openPanel.url!)
                let package = PackageAnalyser(packageUrl: openPanel.url!)
                let main = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "MainWindow") as! NSWindowController
                let mainVc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as! ViewController
                mainVc.package = package
                main.window?.contentViewController = mainVc
                main.window?.makeKeyAndOrderFront(nil)
                mainVc.populateDropdown()
            
            
            
        })
    }

}

