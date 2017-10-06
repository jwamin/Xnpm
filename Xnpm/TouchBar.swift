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
    static let Scrubber = NSTouchBarItemIdentifier("Scrubber")
    static let TextScrubberItemIdentifier = NSTouchBarItemIdentifier("TextScrubberItemIdentifier")
}

@available(OSX 10.12.2, *)
class ScriptsPopover : NSTouchBar, NSScrubberDelegate,NSScrubberDataSource{
    
    var presentingItem: NSPopoverTouchBarItem?
    
    var control:NSPopUpButton
    
    func dismiss(_ sender: Any?) {
        guard let popover = presentingItem else { return }
        popover.dismissPopover(sender)
    }
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        return control.numberOfItems
    }
    
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        print(scrubber)
        let itemView = scrubber.makeItem(withIdentifier: "ScrubberItem", owner: self) as! NSScrubberTextItemView
        itemView.title = control.itemTitles[index]
        return itemView
    }
    
    init(_ scriptsObject:NSPopUpButton) {
        control = scriptsObject
        super.init()
        delegate = self
        
        var items:[NSTouchBarItemIdentifier] = [.Scrubber]
        
//        for item in scriptsObject.itemTitles{
//            items.append(.button)
//        }
        
        defaultItemIdentifiers = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionHandler(_ sender:Any){
        print("button pressed")
        self.dismiss(sender)
    }
    
}



// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ScriptsPopover: NSTouchBarDelegate {
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
        case NSTouchBarItemIdentifier.Scrubber:
            let scrubberItem = NSCustomTouchBarItem(identifier: identifier)
            let scrubber = NSScrubber()
            scrubber.register(NSScrubberTextItemView.self, forItemIdentifier: "ScrubberItem")
            scrubber.scrubberLayout = NSScrubberFlowLayout()
            scrubber.dataSource = self
            scrubber.delegate = self
            scrubber.mode = .free
            scrubber.selectionBackgroundStyle = NSScrubberSelectionStyle.roundedBackground
            scrubberItem.view = scrubber
            return scrubberItem
            
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

