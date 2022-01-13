// Lots of this is from https://github.com/acwright/SwiftUIMenuBar

import Cocoa
import SwiftUI

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @State var defaultCount : Int
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var statusBarMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       
        createPopover()
       
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
            withTitle: "Open Preferences",
            action: #selector(openPrefs),
            keyEquivalent: "p"
        )
        statusBarMenu.addItem(
            withTitle: "Quit Deep Breath",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
    }
    
    @objc func createPopover() {
        // Create the SwiftUI view that provides the window contents.
        let popoverView = PopoverView(count: defaultCount)
        
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: popoverView)
        self.popover = popover
    }

    @objc func menuDidClose(_ menu: NSMenu) {
        statusBarItem.menu = nil // remove menu so button works as before
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
            let event = NSApp.currentEvent!
            
            // Right click
            // this only works after you've left clicked once
            if event.type == NSEvent.EventType.rightMouseUp {
                statusBarItem.menu = statusBarMenu
                statusBarItem.button?.performClick(nil)
                menuDidClose(statusBarMenu)
            
            // Left click
            } else if (event.type == NSEvent.EventType.leftMouseUp) {
                if self.popover.isShown {
                    self.popover.performClose(sender)
                } else {
                    NSApp.activate(ignoringOtherApps: true) // not sure if this line is needed
                    self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
    }
    
    // If popover clicked out off
    func applicationWillResignActive(_ notification: Notification) {
        // reset popover by recreating it
        createPopover()
        menuDidClose(statusBarMenu)
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
