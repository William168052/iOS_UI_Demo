//
//  QueryBorrowInfoVC.swift
//  数据库大作业
//
//  Created by William on 2018/5/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class QueryBorrowInfoVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray : [BorrowInfo]?
    
    let dataBaseTool = ZWTSQLiteTool.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "借阅记录"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryBorrowInfoFromDataBase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryBorrowInfoFromDataBase() {
        self.dataArray = Array<BorrowInfo>.init()
        //判断当前用户身份
        let currentUser = User.shareInstance
        print(currentUser)
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
        }

        var result : FMResultSet?
        if currentUser?.identifier == UserIdentifier.administrator.rawValue {
            //管理员
            result = self.dataBaseTool.dataBase?.executeQuery("select UserName,Book_Table.BookID,Book_Table.BookName,borrowNumber from Borrow_Table,Book_Table where Borrow_Table.BookID = Book_Table.BookID", withArgumentsIn: [])
        }else{
            //普通用户
            result = self.dataBaseTool.dataBase?.executeQuery("select UserName,Book_Table.BookID,Book_Table.BookName,borrowNumber from Borrow_Table,Book_Table where Borrow_Table.BookID = Book_Table.BookID and Borrow_Table.UserName = ?", withArgumentsIn: [currentUser?.userName as Any])
        }
        if result != nil {
            while (result?.next())! {
                let userName = result?.string(forColumn: "UserName")
                let bookID = result?.string(forColumn: "BookID")
                let bookName = result?.string(forColumn: "BookName")
                let borrowNumber = result?.int(forColumn: "borrowNumber")
                
                self.dataArray?.append(BorrowInfo.init(userName: userName, bookID: bookID,bookName: bookName, borrowNumber: Int(borrowNumber!)))
            }
        }
        self.dataBaseTool.dataBase?.close()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BorrowInfoTableViewCell.tableViewCell(tableView: tableView)
        let info = self.dataArray![indexPath.row]
        cell?.userNameLabel.text = info.userName
        cell?.bookNameLabel.text = info.bookName
        cell?.bookIDLabel.text = info.bookID
        cell?.bookNumberLabel.text = String.init(format: "%d", info.borrowNumber!)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action_1 = UITableViewRowAction.init(style: .destructive, title: "还书") { (rowAction, indexPath) in
            //弹框确认
            let alert = UIAlertController.init(title: "确认还书？", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认", style: .destructive, handler: { (action) in
                //从借阅记录中删除
                let cell = tableView.cellForRow(at: indexPath) as! BorrowInfoTableViewCell
                let ID = cell.bookIDLabel.text
                if self.dataBaseTool.deleteFromTable(sql: "delete from Borrow_Table where UserName = ? and BookID = ?", arguments: [User.shareInstance?.userName as Any,ID!]) == false {
                    UIView.alertMessage(title: "注意", message: "还书失败", preferredStyle: .alert, target: self, compelete: nil)
                    
                }else{
                    
                    //刷新表格以及数据源
                    self.queryBorrowInfoFromDataBase()
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            }))
            alert.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        return [action_1]
    }

}
