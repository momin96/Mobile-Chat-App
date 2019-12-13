//
//  ViewController.swift
//  Mobile Chat App
//
//  Created by Nasir Ahmed Momin on 13/12/19.
//  Copyright © 2019 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xmppController: XMPPController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        try! self.xmppController = XMPPController(withHostName: "host.com", userJID: "user@host.com", hostPort: 5222, password: "password")
        
        self.xmppController?.connect()
    }


}

