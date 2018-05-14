//
//  SQLiteDBTool.swift
//  iOS-SQLite的使用
//
//  Created by William on 2018/5/11.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class SQLiteDBTool: NSObject {
    var docPath : String?
    
    /*
     *  docPath : 沙盒地址（数据库保存的地方）
     */
    init(docPath : String!) {
        self.docPath = docPath
    }
    
    //添加数据
    func insertData()

}
