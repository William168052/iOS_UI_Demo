//
//  User.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class User: NSObject {
    var userName : String?
    var passWord : String?
    var identifier : String?
    
    static var shareInstance:User?
    
    override init() {
    }
    
    init(userName:String,passWord:String,identifier:String) {
        self.userName = userName
        self.passWord = passWord
        self.identifier = identifier
        
    }
    
    static func login(userName:String,passWord:String,identifier:String) {
        shareInstance = User.init(userName: userName, passWord: passWord, identifier: identifier)
    }
    
    static func logOut() {
        shareInstance = nil
    }

}
