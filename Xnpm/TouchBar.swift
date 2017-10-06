//
//  TouchBar.swift
//  Xnpm
//
//  Created by Joss Manger on 10/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

// MARK: -

extension NSTouchBarCustomizationIdentifier {
    static let XnpmTouchBar = NSTouchBarCustomizationIdentifier("XnpmTouchBar")
    static let ScriptspopoverBar = NSTouchBarCustomizationIdentifier("XnpmTouchBarScriptsPopover")
}

extension NSTouchBarItemIdentifier {
    static let label = NSTouchBarItemIdentifier("XnpmTouchBarlabel")
    static let icon = NSTouchBarItemIdentifier("XnpmTouchBaricon")
     static let button = NSTouchBarItemIdentifier("XnpmTouchBarButton")
}

//@available(OSX 10.12.2, *)
//class TouchBarCoordinator : NSObject, NSTouchBarDelegate{
//
//    var touchBaridentifiers:[NSTouchBarItemIdentifier]!
//    var touchBartitle:String!
//
//    init(_ identifiers:[NSTouchBarItemIdentifier],_ title:String) {
//        print("initialised thingy")
//        touchBaridentifiers = identifiers
//        touchBartitle = title
//
//    }
//
//    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
//
//        switch identifier {
//        case NSTouchBarItemIdentifier.label:
//            let custom = NSCustomTouchBarItem(identifier: identifier)
//            let label = NSTextField.init(labelWithString: "Xnpm "+touchBartitle)
//            custom.view = label
//
//            return custom
//        case NSTouchBarItemIdentifier.icon:
//            let custom = NSCustomTouchBarItem(identifier: identifier)
//            let img = NSApp.applicationIconImage!
//            img.size = CGSize(width: 30.0, height: 30.0)
//            let imgview = NSImageView(image: img)
//            imgview.frame.size = CGSize(width: imgview.frame.width, height: 30.0)
//            imgview.imageScaling = .scaleProportionallyUpOrDown
//            custom.view = imgview
//            print("something")
//            return custom
//        default:
//            return nil
//        }
//
//    }
//
//    func makeTouchBar() -> NSTouchBar? {
//        let touchBar = NSTouchBar()
//        touchBar.delegate = self
//        touchBar.customizationIdentifier = .XnpmTouchBar
//        touchBar.defaultItemIdentifiers = touchBaridentifiers
//        print(touchBar)
//        return touchBar
//    }
//
//}

