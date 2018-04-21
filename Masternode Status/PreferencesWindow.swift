//
//  PreferencesWindow.swift
//  Masternode Status
//
//  Created by Dillon on 4/20/18.
//  Copyright © 2018 Dillon Petito. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

//override var windowNibName : String! {
//    return "PreferencesWindow"
//}
class PreferencesWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var addressTextField: NSTextField!
    override var windowNibName: NSNib.Name{ return NSNib.Name(rawValue: "PreferencesWindow")}
    var delegate: PreferencesWindowDelegate?
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(addressTextField.stringValue, forKey: "address")
        delegate?.preferencesDidUpdate()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        let defaults = UserDefaults.standard
        let address = defaults.string(forKey: "address") ?? DEFAULT_ADDRESS
        addressTextField.stringValue = address
    }
}
