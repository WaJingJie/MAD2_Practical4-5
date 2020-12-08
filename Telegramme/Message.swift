//
//  Message.swift
//  Telegramme
//
//  Created by MAD2 on 26/11/20.
//

import Foundation

class Message{
    var text:String
    var sender:Bool
    var date:Date
    
    init(t:String, s:Bool, d:Date){
        self.text = t
        self.sender = s
        self.date = d
    }
}
