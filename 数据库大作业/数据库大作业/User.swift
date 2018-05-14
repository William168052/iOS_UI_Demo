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
    var identifier : UserIdentifier?
    
    init(userName:String,passWord:String,identifier:UserIdentifier) {
        self.userName = userName
        self.passWord = passWord
        self.identifier = identifier
    }

}
