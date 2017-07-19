//
//  WindowController.swift
//  Xnpm
//
//  Created by Joss Manger on 6/11/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        
        
    }


}


class MyCrazyValueTransformer:ValueTransformer{
    public func transformedValue(value: AnyObject?) -> AnyObject? {
        let retval = value
        
        if let index = value as? Int {
            if(UInt(index) == UInt.max){
                return false as AnyObject
            }
        }
        
        return retval
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
