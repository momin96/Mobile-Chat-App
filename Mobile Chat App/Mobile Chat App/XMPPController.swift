//
//  XMPPController.swift
//  Mobile Chat App
//
//  Created by Nasir Ahmed Momin on 13/12/19.
//  Copyright © 2019 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import XMPPFramework

enum XMPPError: Error {
    case wrongUserJID
}

class XMPPController: NSObject {
    
    var stream: XMPPStream?
    
    var hostName: String?
    var userJID: XMPPJID?
    var hostPort: UInt16?
    var password: String?
    
    init(withHostName name: String, userJID jid: String, hostPort port: UInt16, password pwd: String) throws {
        
        guard let uJID = XMPPJID(string: jid) else {
            throw XMPPError.wrongUserJID
        }
        
        hostName    = name
        userJID     = uJID
        hostPort    = port
        password    = pwd
        
        // Stream Configuration
        stream = XMPPStream()
        stream?.hostName = name
        stream?.myJID = uJID
        stream?.hostPort = port
        stream?.startTLSPolicy = .allowed
        
        super.init()
        
        stream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func connect() {
        if !stream!.isDisconnected {
            return
        }
        
        try! stream?.connect(withTimeout: XMPPStreamTimeoutNone)
    }
}

extension XMPPController: XMPPStreamDelegate {
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("Stream Connected")
        try! stream?.authenticate(withPassword: password!)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("Stream: Authnticated")
        stream?.send(XMPPPresence())
    }
}
