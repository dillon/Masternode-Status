//
//  StatusMenuController.swift
//  Masternode Status
//
//  Created by Dillon on 4/20/18.
//  Copyright © 2018 Dillon Petito. All rights reserved.
//

import Cocoa
let DEFAULT_ADDRESS = "XR7MG4FR2JrZM2jvMjhChj99iJVRX52yz1"
var preferencesWindow: PreferencesWindow!
class StatusMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    var xumaMenuItem: NSMenuItem!
    
    let xumaAPI = XumaAPI()

    func preferencesDidUpdate() {
        updateXuma()
    }
    
    override func awakeFromNib() {
        statusItem.title = "Xuma" // set to variable later
        statusItem.menu = statusMenu
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        updateXuma()
    }
    
//    func updateXuma() {
//        xumaAPI.fetchXuma("XR7MG4FR2JrZM2jvMjhChj99iJVRX52yz1") { xuma in
//            self.statusItem.title = xuma.description + " XMX"
//        }
//    }
    
    var helloWorldTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: Selector(("updateXuma")), userInfo: nil, repeats: true)


    func updateXuma() {

        let defaults = UserDefaults.standard
        let address = defaults.string(forKey: "address") ?? DEFAULT_ADDRESS
        xumaAPI.fetchXuma(address) { xuma in
            self.statusItem.title = xuma.description + " XMX"
        }
        
    }

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    @IBAction func updateClicked(_ sender: NSMenuItem) {
        updateXuma()
    }
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}



