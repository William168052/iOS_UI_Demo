//
//  ZWTSQLiteTool.swift
//  数据库大作业
//
//  Created by William on 2018/5/15.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class ZWTSQLiteTool: NSObject {

    static let shareInstance = ZWTSQLiteTool()
    
    var dataBase : FMDatabase?
    
    override init() {
        
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        //数据库路径
        let dbPath = documentPath.appendingPathComponent("DataBase.sqlite") as String
        print(dbPath)
        // MARK:创建数据库
        self.dataBase = FMDatabase.init(path: dbPath)
        
        
    }
    

    // MARK:创建表
    func createTable(sql:String)->Bool{
        //打开数据库
        if !(self.dataBase?.open())! {
            print("数据库打开失败")
            return false
        }
        let flag = self.dataBase?.executeUpdate(sql, withArgumentsIn: [])
        self.dataBase?.close()
        return flag!
    }
    
    // MARK:修改表
    func updateTable(sql:String,arguments:[Any])->Bool{
        //打开数据库
        if !(self.dataBase?.open())! {
            print("数据库打开失败")
            return false
        }
        let flag = self.dataBase?.executeUpdate(sql, withArgumentsIn: arguments)
        self.dataBase?.close()
        return flag!
    }
    
    // MARK:删除表
    func deleteFromTable(sql:String,arguments:[Any])->Bool{
        return self.updateTable(sql:sql,arguments:arguments)
    }
    
    // MARK:创建触发器
    func createTrigger(sql:String) -> Bool {
        //打开数据库
        if !(self.dataBase?.open())! {
            print("数据库打开失败")
            return false
        }
        let flag = self.dataBase?.executeUpdate(sql, withArgumentsIn: [])
        self.dataBase?.close()
        return flag!
    }
    
    
    
}
