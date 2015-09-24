//
//  Message.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 11/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class Message {
    
    let objectid: String
    let sender: String
    let recipient: String
    let subject: String
    let text: String
    let timestamp: NSDate
    
    init(objectid: String, sender: String, recipient: String, subject: String, timestamp: NSDate, text: String){
        self.objectid = objectid
        self.sender = sender
        self.recipient = recipient
        self.subject = subject
        self.text = text
        self.timestamp = timestamp
    }
    
    
    
}
