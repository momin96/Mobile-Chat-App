//
//  ViewController.swift
//  Mobile Chat App
//
//  Created by Nasir Ahmed Momin on 13/12/19.
//  Copyright © 2019 Nasir Ahmed Momin. All rights reserved.
//

import UIKit
import XMPPFramework

class ViewController: UIViewController, XMPPStreamDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        XMPPController.sharedInstance.stream?.addDelegate(self, delegateQueue: DispatchQueue.main)
        
        XMPPController.sharedInstance.connect(withHostName: "host.com", userJID: "user@host.com", hostPort: 5222, password: "password")
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
           print(#function)
       }
       
       func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
           print(error)
       }
}
