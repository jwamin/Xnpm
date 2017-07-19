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
* Error handling when wrong file is selected.
* OpenPanel sheet modal on List view controller.
* Table view events and bindings, double click, removeAtIndex, delete key.

## TODO
* Richer interface utilising more design guidelines.
* Handle errors on incorrect / poorly formed JSON.
* remove / rearrage Project list, clear.
* Clean up NSMenus
* Refresh projects with update button / lifecycle method (done with button, window became key delegate method)
* Icons / Images
* More NSDocumentController functionality? Use instead of NSUD to handle previously opened files.
* Open `package.json` in default external text editor (done)
* detection of Node Modules folder, status lights, `npm i` button
* hide `postinstall` task from scripts dropdown (done)
* TouchBar

### Techniques Used
* Parsing JSON with Swift
* NSDocumentController and OpenPanel
* NSWindowController
* 'Recently opened' Menu Item
* Cocoa bindings
* Custom protocol
* NSTask to spin off Node processes
* NSNotification observers and handling
* Bridging Obj-C class to Swift
* Custom Protocol to notify table view (Depricated)

#### Frameworks Used
`Cocoa`
`Foundation`
