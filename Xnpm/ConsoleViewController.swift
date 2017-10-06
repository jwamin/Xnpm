//
//  ConsoleViewController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/29/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class ConsoleViewController: NSViewController,NSWindowDelegate {

    @IBOutlet weak var touchBarButton: NSButton!
    @IBOutlet var textView: NSTextView!
    var parentController:ViewController?
    
    @IBOutlet weak var indicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleText), name: NSNotification.Name(rawValue: "gotOut"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnd), name: NSNotification.Name(rawValue: "gotEnd"), object: nil)
        if #available(OSX 10.12.2, *) {
        touchBarButton.image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)
            indicator.startAnimation(self)
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self;
    }
    
    override func awakeFromNib() {
        
        print("hello world")
        textView.font = NSFont(name: "Andale Mono", size: 11.0)
    }
    
    func handleText(notification:NSNotification){
        print(notification.object ?? "none")
        
        let dict = notification.object as! NSDictionary
        let str = dict.object(forKey: "str") as! String
        let notificationID = dict.object(forKey: "sender") as! String
        if let identifier = parentController?.package.packageTitle{
            if(identifier==notificationID){
               updateTextView(str: str)
            }
            
            
        }
        
        
        
    }
    func handleEnd(notification:NSNotification){
        print(notification.object ?? "none")
        updateTextView(str: notification.object as! String)
    }
    
    func updateTextView(str:String){
        
        // Smart Scrolling
        let scroll = (NSMaxY(textView.visibleRect) == NSMaxY(textView.bounds));
        
        // Append string to textview
        textView.textStorage?.append(NSAttributedString(string: str))
        
        //Set Font
        textView.textStorage?.font = NSFont(name: "Andale Mono", size: 11.0)

        if (scroll){
            textView.scrollRangeToVisible(NSMakeRange((textView.string?.characters.count)!, 0));
        }// Scroll to end of the textview contents
        
    }
    
    func windowShouldClose(_ sender: Any) -> Bool {
        self.parentController?.executeScript(sender: self)
        return false;
    }
    
    func removeObservers(){
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "gotOut"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "gotEnd"), object: nil)

    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewDidDisappear() {
        removeObservers()
    }
    
}


