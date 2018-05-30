//
//  BorrowInfo.swift
//  数据库大作业
//
//  Created by William on 2018/5/30.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BorrowInfo: NSObject {
    var userName : String?
    var bookID : String?
    var bookName : String?
    var borrowNumber : Int?
    
    
    init(userName:String?,bookID:String?,bookName:String?,borrowNumber:Int?) {
        self.userName = userName
        self.bookID = bookID
        self.bookName = bookName
        self.borrowNumber = borrowNumber
        
    }
}
