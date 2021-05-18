//
//  AppDelegate.swift
//  QuickCode
//
//  Created by Alexis Akers on 3/11/21.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover

        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.squareLength))
        statusBarItem.behavior = [.removalAllowed, .terminationOnRemoval]
        statusBarItem.isVisible = true

        if let button = self.statusBarItem.button {
            let itemImage = NSImage(named: "StatusBarIcon")
            itemImage?.isTemplate = true
            itemImage?.size = CGSize(width: 17, height: 17)

            button.image = itemImage
            button.action = #selector(togglePopover(_:))
        }
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

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
