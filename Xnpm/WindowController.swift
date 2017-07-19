//
//  WindowController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/11/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true;
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        
        
    }


}

//@available(OSX 10.12.2, *)
//extension WindowController:NSTouchBarDelegate{
//    
//    override func makeTouchBar() -> NSTouchBar? {
//        let touchBar = NSTouchBar()
//        touchBar.delegate = self
//        
//        return touchBar
//    }
//    
//}
