//
//  Book.swift
//  数据库大作业
//
//  Created by William on 2018/5/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class Book: NSObject {
    var bookID : String?
    var bookName : String?
    var bookNumber : Int?
    var bookAuthor : String?
    var bookPublic : String?
    static let properties = ["书籍编号","书名","书籍数量","作者","出版社"]
    
    init(id:String,name:String,number:Int,author:String,publicName:String) {
        self.bookID = id
        self.bookName = name
        self.bookNumber = number
        self.bookAuthor = author
        self.bookPublic = publicName
    }
    
    

}
