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
        
        //Instantiate package object
        let package = PackageAnalyser(packageUrl: url)
        
        for window in NSApplication.shared().windows {
            if let vc = window.contentViewController as? ViewController{
                if (vc.package.packageTitle==package.packageTitle){
                    print("got at hit \(window)")
                    window.makeKeyAndOrderFront(nil)
                    return
                }
            }
        }
        
        let main = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "MainWindow") as! WindowController
        let mainVc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as! ViewController
        mainVc.package = package
        main.window?.title = "Xnpm Project - "+package.packageTitle
        main.window?.contentViewController = mainVc
        main.window?.makeKeyAndOrderFront(nil)
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let url = URL(fileURLWithPath: filename)
        handleOpen(url: url)
        return true
    }
    
    func checkandAddToDefaults(url:URL){
        print(url)
        let projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        var match:Bool = false;

            for u in projects.enumerated(){
                if(url.absoluteString == u.element){
                    match = true;
                }
            }
        
        if(!match){
            var array = projects
            array.append(url.absoluteString)
            let immutableArray = NSArray(array: array)
            print(immutableArray)
            UserDefaults.standard.set(immutableArray, forKey: "projects")
            UserDefaults.standard.synchronize()
            listView?.updateNotify()
        }

    }
    
    @IBAction func openAction(_ sender: Any) {
        
        print("open called")
        
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["json"];
        openPanel.canChooseDirectories = false;
        
        func completionHandler(number:Int){
            
            func alert(_ message:String){
                let alert = NSAlert()
                alert.alertStyle = .critical
                alert.messageText = "\(message)"
                alert.runModal()
            }
            
            if let gotURL = openPanel.url{
                if(gotURL.pathComponents.last == "package.json"){
                    NSDocumentController.shared().noteNewRecentDocumentURL(gotURL)
                    self.checkandAddToDefaults(url: gotURL)
                    self.handleOpen(url: gotURL)
                } else {
                    alert("\(gotURL) is not a valid npm package manifest (package.json)")
                }
                
            } else {
                return
            }
            
        }
        guard let window = sender as? NSWindow else {
            openPanel.begin(completionHandler: completionHandler)
            return
        }
        print("didnt fall through")
            openPanel.beginSheetModal(for: window, completionHandler: completionHandler)
        
        
    }
    
    
    
}

