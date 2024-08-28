import Cocoa
import SwiftUI

class PopoverManager: ObservableObject {
  private var statusItem: NSStatusItem?
  private var popover: NSPopover

  init() {
    popover = NSPopover()
    let contentView = ContentView()

    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: contentView)

    createStatusBarItem()
  }

  private func createStatusBarItem() {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    if let button = statusItem?.button {
      button.image = NSImage(named: "MenuBarIcon")
      button.image?.isTemplate = true
      button.action = #selector(togglePopover(_:))
      button.target = self
    }
  }

  @objc private func togglePopover(_ sender: AnyObject?) {
    if let button = statusItem?.button {
      if popover.isShown {
        popover.performClose(sender)
      } else {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
      }
    }
  }
}
