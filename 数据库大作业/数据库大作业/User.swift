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
    
    init(userName:String,passWord:String,identifier:String) {
        self.userName = userName
        self.passWord = passWord
        self.identifier = identifier
    }

}
