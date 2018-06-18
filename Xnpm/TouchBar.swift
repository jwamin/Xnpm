//
//  TouchBar.swift
//  Xnpm
//
//  Created by Joss Manger on 10/6/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa



extension NSTouchBarCustomizationIdentifier {
    fileprivate static let XnpmTouchBar = NSTouchBarCustomizationIdentifier("XnpmTouchBar")
    fileprivate static let ScriptspopoverBar = NSTouchBarCustomizationIdentifier("XnpmTouchBarScriptsPopover")
}

extension NSTouchBarItemIdentifier {
    fileprivate static let label = NSTouchBarItemIdentifier("XnpmTouchBarlabel")
    fileprivate static let icon = NSTouchBarItemIdentifier("XnpmTouchBaricon")
    fileprivate static let button = NSTouchBarItemIdentifier("XnpmTouchBarButton")
    fileprivate static let scriptButton = NSTouchBarItemIdentifier("XnpmTouchBarScriptButton")
    fileprivate static let gearButton = NSTouchBarItemIdentifier("XnpmTouchBarGearButton")
    fileprivate static let refreshButton = NSTouchBarItemIdentifier("XnpmTouchBarRefreshButton")
    fileprivate static let Scrubber = NSTouchBarItemIdentifier("Scrubber")
    fileprivate static let TextScrubberItemIdentifier = NSTouchBarItemIdentifier("TextScrubberItemIdentifier")
}


// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension WindowController: NSTouchBarDelegate {
    
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .XnpmTouchBar
        touchBar.defaultItemIdentifiers = [.icon,.label, .fixedSpaceLarge, .otherItemsProxy]
        
        return touchBar
    }
    
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

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let identifiers:[NSTouchBarItemIdentifier] = [.icon,.label,.button,.scriptButton,.gearButton,.refreshButton]
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .XnpmTouchBar
        touchBar.defaultItemIdentifiers = identifiers //[.icon,.label, .fixedSpaceLarge, .otherItemsProxy]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
        case NSTouchBarItemIdentifier.label:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField.init(labelWithString: "Xnpm "+package.packageTitle)
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
        case NSTouchBarItemIdentifier.button:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            var image = NSImage(named: NSImageNameTouchBarPlayTemplate)!
            if(taskRunning){
                image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)!
            }
            let button = NSButton(image: image, target: self, action: #selector(executeScript(sender:)))
            buttonItem.view = button
            return buttonItem
        case NSTouchBarItemIdentifier.scriptButton:
            let buttonItem = NSPopoverTouchBarItem(identifier: .scriptButton)
            buttonItem.collapsedRepresentationImage = NSImage(named: "NSPathTemplate")
            buttonItem.collapsedRepresentationLabel = "Script: \(scriptDropdown.selectedItem!.title)"
            buttonItem.popoverTouchBar = ScriptsPopover(self.scriptDropdown,self) as ScriptsPopover
            (buttonItem.popoverTouchBar as! ScriptsPopover).presentingItem = buttonItem
            return buttonItem
        case NSTouchBarItemIdentifier.gearButton:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            var image = NSImage(named: "NSActionTemplate")!
            let button = NSButton(image: image, target: self, action: #selector(editInExternalEditor(_:)))
            buttonItem.view = button
            return buttonItem
        case NSTouchBarItemIdentifier.refreshButton:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            var image = NSImage(named: "NSRefreshTemplate")!
            let button = NSButton(image: image, target: self, action: #selector(refresh(_:)))
            buttonItem.view = button
            return buttonItem
        default:
            return nil
        }
        
    }
    
    func updateScriptButton(){
        guard let touchBar = touchBar else { return }
        print("got touchbar")
        for itemIdentifier in touchBar.itemIdentifiers {
            guard let item = touchBar.item(forIdentifier: itemIdentifier) as? NSPopoverTouchBarItem else {continue}
            
            if(itemIdentifier == NSTouchBarItemIdentifier.scriptButton){
                print("got here")
                item.collapsedRepresentationLabel = "Script: \(scriptDropdown.selectedItem!.title)"
            }
            
        }
    }
    
    
    func customizeActionButton(_ isrunning:Bool){
        
        guard let touchBar = touchBar else { return }
        print("got touchbar")
        for itemIdentifier in touchBar.itemIdentifiers {
            guard let item = touchBar.item(forIdentifier: itemIdentifier) as? NSCustomTouchBarItem,
                let button = item.view as? NSButton else {continue}
            
            if(itemIdentifier == NSTouchBarItemIdentifier.button){
                print("got here")
                
                var image = NSImage(named: NSImageNameTouchBarPlayTemplate)!
                if(isrunning){
                    image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)!
                }
                
                button.image = image
            }
            
        }
    }
    
    
}


@available(OSX 10.12.2, *)
extension ConsoleViewController: NSTouchBarDelegate {
    
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let identifiers:[NSTouchBarItemIdentifier] = [.icon,.label,.button]
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .XnpmTouchBar
        touchBar.defaultItemIdentifiers = identifiers //[.icon,.label, .fixedSpaceLarge, .otherItemsProxy]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
        case NSTouchBarItemIdentifier.label:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField.init(labelWithString: "Xnpm "+parentController!.package.packageTitle)
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
            //print("something")
            return custom
        case NSTouchBarItemIdentifier.button:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            let image = NSImage(named: NSImageNameTouchBarRecordStopTemplate)!
            let button = NSButton(image: image, target: self, action: #selector(windowShouldClose(_:)))
            buttonItem.view = button
            return buttonItem
        default:
            return nil
        }
        
    }
    
    
    
}


// MARK: - Popover Scripts touchbar

@available(OSX 10.12.2, *)
class ScriptsPopover : NSTouchBar, NSScrubberDelegate,NSScrubberDataSource,NSScrubberFlowLayoutDelegate{
    //refactor this to use scrollable buttons instead of scrubber
    var presentingItem: NSPopoverTouchBarItem?
    var parentViewController:ViewController?
    var control:NSPopUpButton
    
    func dismiss(_ sender: Any?) {
        print(self)
        guard let popover = presentingItem else { return }
        popover.dismissPopover(self)
    }
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        return control.numberOfItems
    }
    
    // Scrubber is asking for the size for a particular item.
    func scrubber(_ scrubber: NSScrubber, layout: NSScrubberFlowLayout, sizeForItemAt itemIndex: Int) -> NSSize {
        let size = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        // Specify a system font size of 0 to automatically use the appropriate size.
        let title = control.itemTitles[itemIndex]
        let textRect = title.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin],
                                          attributes: nil)
        //+6:  spacing.
        //+10: NSTextField horizontal padding, no good way to retrieve this though.
        var width: CGFloat = 100.0
        if let image = NSImage(named: "NSPathTemplate") {
            width = textRect.size.width + image.size.width + 6 + 10 + 10
        }
        let returnsize = NSSize(width: width, height: 30)
        print(textRect,returnsize)
        return returnsize
    }
    
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
  
        let itemView = scrubber.makeItem(withIdentifier: "ScrubberItem", owner: self) as! NSScrubberTextItemView
        itemView.title = control.itemTitles[index]    
        return itemView
    }
    
    func scrubber(_ scrubber: NSScrubber, didSelectItemAt selectedIndex: Int) {
        control.selectItem(at: selectedIndex)
        print("whaa?")
        dismiss(self)
        parentViewController?.changed(self)
    }
    
    init(_ scriptsObject:NSPopUpButton,_ parentVC:ViewController) {
        control = scriptsObject
        super.init()
        delegate = self
        parentViewController = parentVC
        
        let items:[NSTouchBarItemIdentifier] = [.Scrubber]
        
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
        //refactor this to use scrollable buttons instead of scrubber
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




