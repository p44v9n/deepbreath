// Lots of this is from https://github.com/acwright/SwiftUIMenuBar

import Cocoa
import SwiftUI

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @State var defaultCount = 5
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var statusBarMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the SwiftUI view that provides the window contents.
        //let popoverView = PopoverView(defaultCountImport: $defaultCount)
        let popoverView = PopoverView(count: defaultCount)
        
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: popoverView)
        self.popover = popover
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        // Create button image and action
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
            button.action = #selector(togglePopover(_:))
        }
        
        NSApp.activate(ignoringOtherApps: true)
        
        // Create right click menu
        statusBarMenu = NSMenu(title: "Status Bar Menu")
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q")

    }
    
    //right click - this isnt working
    @objc func statusBarButtonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type ==  NSEvent.EventType.rightMouseUp {
            print("Right click!")
            statusBarItem.menu = statusBarMenu // add menu to button...
            statusBarItem.button?.performClick(nil) // ...and click
        } else {
            print("Left click!")
        }
    }

    @objc func menuDidClose(_ menu: NSMenu) {
        statusBarItem.menu = nil // remove menu so button works as before
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    @objc func openPrefs(){
        NSLog("Open preferences window")
        let prefsView = PrefsView(defaultCount: $defaultCount)

        let preferencesWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 700, height: 610),
            styleMask: [.closable, .titled],
            backing: .buffered,
            defer: false
        )

        preferencesWindow.title = "DeepBreath Preferences"
        preferencesWindow.contentView = NSHostingView(rootView: prefsView)
        preferencesWindow.makeKeyAndOrderFront(nil)
        // allow the preference window can be focused automatically when opened
        NSApplication.shared.activate(ignoringOtherApps: true)

        let controller = NSWindowController(window: preferencesWindow)
        controller.showWindow(self)

        preferencesWindow.center()
        preferencesWindow.orderFrontRegardless()
    }
    
    
    
    
}
