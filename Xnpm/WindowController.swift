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


    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .XnpmTouchBar
        touchBar.defaultItemIdentifiers = [.icon,.label, .fixedSpaceLarge, .otherItemsProxy]
        
        return touchBar
    }
    
    func windowWillClose(_ notification: Notification) {
        let delegate = NSApp.delegate as! AppDelegate
        delegate.projectViewWindow = nil
    }
    
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension WindowController: NSTouchBarDelegate {
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
        case NSTouchBarItemIdentifier.label:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField.init(labelWithString: NSLocalizedString("Xnpm", comment:""))
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
        default:
            return nil
        }
    }
}

class Window: NSWindow {
    
}
