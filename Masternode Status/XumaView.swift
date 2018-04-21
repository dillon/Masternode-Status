//
//  XumaView.swift
//  Masternode Status
//
//  Created by Dillon on 4/20/18.
//  Copyright © 2018 Dillon Petito. All rights reserved.
//

import Cocoa

class XumaView: NSView {
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var WalletAddressTextField: NSTextField!
    @IBOutlet weak var AssetsTextField: NSTextField!
    
    
    func update(_ xuma: Xuma) {
        // do UI updates on the main thread
        DispatchQueue.main.async {
            self.WalletAddressTextField.stringValue = xuma.address;
            self.AssetsTextField.stringValue = xuma.temp +  " XMX"
        }
    }

}

