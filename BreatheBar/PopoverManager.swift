import Cocoa
import SwiftUI

class PopoverManager: ObservableObject {
  private var statusItem: NSStatusItem?
  private var popover: NSPopover
  private var shadeWindow: ShadeWindow?
  private var reminderTimer: Timer?

  @ObservedObject private var preferencesManager = PreferencesManager.shared

  init() {
    popover = NSPopover()
    let contentView = ContentView()

    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: contentView)

    createStatusBarItem()
    setupReminderTimer()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(setupReminderTimer),
      name: NSApplication.didBecomeActiveNotification,
      object: nil
    )
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

  @objc public func togglePopover(_ sender: AnyObject?) {
    if let button = statusItem?.button {
      if popover.isShown {
        // this line is not working
        shadeWindow?.fadeOut()
        popover.performClose(sender)
      } else {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
      }
    }
  }

    @objc private func setupReminderTimer() {
    reminderTimer?.invalidate()

    guard preferencesManager.enableHourlyReminders else { return }

    let nextReminderDate = calculateNextReminderDate()
    let delay = nextReminderDate.timeIntervalSinceNow

    reminderTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
      self?.showReminder()
      self?.setupReminderTimer()  // Set up the next reminder
    }
  }

  private func calculateNextReminderDate() -> Date {
    let calendar = Calendar.current
    let now = Date()
    var components = calendar.dateComponents([.year, .month, .day, .hour], from: now)

    components.minute = preferencesManager.reminderMinute
    components.second = 0

    var nextReminderDate = calendar.date(from: components)!

    if nextReminderDate <= now {
      nextReminderDate = calendar.date(byAdding: .hour, value: 1, to: nextReminderDate)!
    }

    return nextReminderDate  // Add this line
  }

  private func setupHourlyReminderTimer() {
    reminderTimer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { [weak self] _ in
      self?.showReminder()
    }
  }

  private func showReminder() {
    if let button = statusItem?.button {
      popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
  }

  @objc private func reminderSettingsChanged() {
    setupReminderTimer()
  }

  // Add this method to update the reminder timer when preferences change
  func updateReminderSettings() {
    setupReminderTimer()
  }
}
