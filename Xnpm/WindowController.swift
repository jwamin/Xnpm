//
//  WindowController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/11/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa




class WindowController: NSWindowController,NSWindowDelegate {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true;
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.delegate = self
        let delegate = NSApp.delegate as! AppDelegate
        delegate.projectViewWindow = self
        
    }



    
    func windowWillClose(_ notification: Notification) {
        let delegate = NSApp.delegate as! AppDelegate
        delegate.projectViewWindow = nil
    }
    
}

// MARK: - NSTouchBarDelegate



class Window: NSWindow {
    
}
