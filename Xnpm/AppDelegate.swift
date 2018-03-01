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
    @IBOutlet var new:NSMenuItem!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
       // print(NSDocumentController.shared())
        
        //NSDocumentController.shared().newDocument(self)
        
        if #available(OSX 10.12.2, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func showProjectView(_ sender: Any) {
        
       
        
       let controller =  NSStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialController() as! WindowController
        
         controller.showWindow(sender)
        
    }
    func handleOpen(url:URL){
        
        //Instantiate package object
        let package = PackageAnalyser(packageUrl: url)
        if(package.valid){
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
        } else {
            
            let alert = NSAlert()
            alert.alertStyle = .critical
            alert.messageText = "package.json is not well formed"
            alert.informativeText = package.error?.userInfo["NSDebugDescription"] as! String
            
            let response = alert.runModal()
            if(response==NSModalResponseCancel){
                removeWithUrl(url: url)
            }
            
            
            
        }
        
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let url = URL(fileURLWithPath: filename)
        print("hello world",url)
        //handleOpen(url: url)
        return true
    }
    
    func checkandAddToDefaults(url:URL){
        print("urlzzz \(url)")
        let projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        var match:Bool = false;
        
        for u in projects.enumerated(){
            if(url.absoluteString == u.element){
                match = true;
            }
        }
        print("match \(match)")
        if(!match){
            print("no match")
            var array = projects
            array.append(url.absoluteString)
            let immutableArray = NSArray(array: array)
            print(immutableArray)
            UserDefaults.standard.set(immutableArray, forKey: "projects")
            UserDefaults.standard.synchronize()
            listView?.updateNotify()
            NSDocumentController.shared().noteNewRecentDocumentURL(url)
            self.handleOpen(url: url)
        }
        
    }
    
    func removeWithUrl(url:URL){
        print(url)
        let projects = UserDefaults.standard.array(forKey: "projects") as? Array<String> ?? []
        let mutable = NSMutableArray(array: projects)
        for u in projects.enumerated(){
            if(url.absoluteString == u.element){
                mutable.removeObject(at: u.offset)
                break;
            }
        }
        
        let newProjects = NSArray(array: mutable)
        UserDefaults.standard.set(newProjects, forKey: "projects")
        UserDefaults.standard.synchronize()
        
        listView?.updateNotify()
        
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
                    
                    self.checkandAddToDefaults(url: gotURL)
                    
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

