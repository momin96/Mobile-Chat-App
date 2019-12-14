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
    
    static let sharedInstance = XMPPController()
    
    var stream: XMPPStream?
    
    var hostName: String?
    var userJID: XMPPJID?
    var hostPort: UInt16?
    var password: String?
    
    override init() {
        self.stream = XMPPStream()
        super.init()
        self.stream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func connect(withHostName name: String, userJID jid: String, hostPort port: UInt16, password pwd: String) {
        
        guard let uJID = XMPPJID(string: jid) else {
            return
//            throw XMPPError.wrongUserJID
        }
        
        hostName    = name
        userJID     = uJID
        hostPort    = port
        password    = pwd
        
        // Stream Configuration
        stream?.hostName = name
        stream?.myJID = uJID
        stream?.hostPort = port
        stream?.startTLSPolicy = .allowed
        
        if stream!.isDisconnected {
            do {
                try stream?.connect(withTimeout: 10)
            }
            catch let e {
                print(e.localizedDescription)
            }
        }
    }
}

extension XMPPController: XMPPStreamDelegate {
    
    func xmppStream(_ sender: XMPPStream, socketDidConnect socket: GCDAsyncSocket) {
        print(#function)
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("Stream Connected")
        try! stream?.authenticate(withPassword: password!)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("Stream: Authnticated")
        stream?.send(XMPPPresence())
    }
    
    func xmppStreamWillConnect(_ sender: XMPPStream) {
        print("xmppStreamWillConnect")
        print(sender.isConnecting)
        print(sender.isConnected)
    }
    
    func xmppStreamConnectDidTimeout(_ sender: XMPPStream) {
        print(#function)
    }
    
    func xmppStream(_ sender: XMPPStream, didReceiveError error: DDXMLElement) {
        print(#function)
        print(error)
    }
    
    func xmppStreamDidRegister(_ sender: XMPPStream) {
        print(#function)
    }
    
    func xmppStream(_ sender: XMPPStream, didNotRegister error: DDXMLElement) {
        print(error)
    }
    
    func xmppStreamDidStartNegotiation(_ sender: XMPPStream) {
        print(sender)
    }
    
}
