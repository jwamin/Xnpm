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
    static let scriptButton = NSTouchBarItemIdentifier("XnpmTouchBarScriptButton")
}

@available(OSX 10.12.2, *)
class ScriptsPopover : NSTouchBar{
    
    var presentingItem: NSPopoverTouchBarItem?
    
    func dismiss(_ sender: Any?) {
        guard let popover = presentingItem else { return }
        popover.dismissPopover(sender)
    }
    
    override init() {
        super.init()
        
        delegate = self
        
        
        
        defaultItemIdentifiers = [.button]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ScriptsPopover: NSTouchBarDelegate {
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
//        case NSTouchBarItemIdentifier.button:
//            let custom = NSCustomTouchBarItem(identifier: identifier)
//            custom.customizationLabel = NSLocalizedString("Button", comment:"")
//            custom.view = NSButton(title: NSLocalizedString("Button", comment:""), target: self, action: #selector(actionHandler(_:)))
//            return custom
//
//        case NSTouchBarItemIdentifier.dismissButton:
//            let custom = NSCustomTouchBarItem(identifier: identifier)
//            custom.customizationLabel = NSLocalizedString("Button Button", comment:"")
//            custom.view = NSButton(title: NSLocalizedString("Close", comment:""), target: self, action: #selector(PopoverTouchBarSample.dismiss(_:)))
//            return custom
//
//        case NSTouchBarItemIdentifier.slider:
//            let sliderItem = NSSliderTouchBarItem(identifier: identifier)
//            let slider = sliderItem.slider
//            slider.minValue = 0.0
//            slider.maxValue = 100.0
//            sliderItem.label = NSLocalizedString("Slider", comment:"")
//
//            sliderItem.customizationLabel = NSLocalizedString("Slider", comment:"")
//            sliderItem.target = self
//            sliderItem.action = #selector(sliderValueChanged(_:))
//
//            sliderItem.minimumValueAccessory = NSSliderAccessory(image: NSImage(named: AssetNames.accounts.rawValue)!)
//            sliderItem.maximumValueAccessory = NSSliderAccessory(image: NSImage(named: AssetNames.bookmark.rawValue)!)
//
//            let viewBindings : [String: NSView] = ["slider": slider]
//            let constraints = NSLayoutConstraint.constraints(withVisualFormat: "[slider(300)]",
//                                                             options: [],
//                                                             metrics: nil,
//                                                             views: viewBindings)
//            NSLayoutConstraint.activate(constraints)
//            return sliderItem
            
        default:
            return nil
        }
    }
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

