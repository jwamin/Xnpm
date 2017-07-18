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

## TODO
* OpenPanel modal on List view controller.
* Richer interface utilising more design guidelines
* Table view events, double click(done), removeAtIndex, delete key.
* Handle errors on incorrect / poorly formed JSON.
* remove / rearrage Project list, clear.
* Clean up NSMenus
* Refresh projects with update button / lifecycle method
* Icons / Images
* More NSDocumentController functionality? Use instead of NSUD to handle previously opened files.
* Open `package.json` in default external text editor
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
