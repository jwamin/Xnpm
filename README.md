# Xnpm
macOS App for Node/NPM projects.

Written in Swift with Objective-C components.

# Features
* Analyse NPM `package.json` files, view package information.
* Select and run from `package.json` scripts object.
* View Task output in console.
* Auto close console window on exit.
* Adds opened projects to list view for opening.
* Stores projects in NSUserDefaults
* Error handling when wrong file is selected + incorrect / poorly formed JSON.
* OpenPanel sheet modal on List view controller.
* Table view events and bindings, double click, removeAtIndex, delete key.
* TouchBar - selection, play-stop of scripts

## TODO
* Richer interface utilising more design guidelines.
* remove / rearrage Project list, clear.
* Clean up NSMenus
* Icons / Images
* More NSDocumentController functionality? Use instead of NSUD to handle previously opened files.
* detection of Node Modules folder, status lights, `npm i` button
* check for node - disable if not present.
* Console window layout fixes.
* Properly cascading windows, hierarchy

### Techniques Used
* Parsing JSON with Swift
* NSDocumentController and OpenPanel
* NSWindowController
* 'Recently opened' Menu Item
* Cocoa bindings
* Custom protocol
* NSTask to spin off Node processes
* Fixes bash path.
* NSNotification observers and handling
* Bridging Obj-C class to Swift
* Custom Protocol to notify table view (Depricated)

#### Frameworks Used
`Cocoa`
`Foundation`
