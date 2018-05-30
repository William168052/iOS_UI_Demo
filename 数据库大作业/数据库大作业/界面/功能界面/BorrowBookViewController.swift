//
//  BorrowBookViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BorrowBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BookTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var booksArray : [Book]?
    
    let dataBaseTool = ZWTSQLiteTool.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "借书"
        self.queryBooksFromDataBase()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func queryBooksFromDataBase() {
        self.booksArray = Array<Book>.init()
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
        }
        let result = self.dataBaseTool.dataBase?.executeQuery("select * from Book_Table", withArgumentsIn: [])
        if result != nil {
            while (result?.next())! {
                let id = result?.string(forColumn: "BookID")
                let name = result?.string(forColumn: "BookName")
                let number = result?.int(forColumn: "BookNumber")
                let author = result?.string(forColumn: "BookAuthor")
                let pub = result?.string(forColumn: "BookPublic")
                self.booksArray?.append(Book.init(id: id!, name: name!, number: Int(number!), author: author!, publicName: pub!))
            }
        }
        self.dataBaseTool.dataBase?.close()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.booksArray?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellID"
        var cell : BookTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? BookTableViewCell
        
        if cell == nil {
            cell = BookTableViewCell.tableViewCell(tableView: tableView, identifier: identifier)
        }
        cell?.delegate = self
        let book : Book? = self.booksArray?[indexPath.row]
        cell?.IDLabel.text = book?.bookID
        cell?.NameLabel.text = book?.bookName
        cell?.authorLabel.text = book?.bookAuthor
        cell?.publicLabel.text = book?.bookPublic
        cell?.residueBook.text = String.init(format: "剩余%d本", (book?.bookNumber)!)
        return cell!
    }
    
    func bookTableViewCell(didClickBorrowButton cell: BookTableViewCell) {
        //拿到借书的信息
        let userName = User.shareInstance?.userName as Any
        let bookID = cell.IDLabel.text as Any
        
        //先去数据库中找是否有相同的记录  如果有只需将借书数+1即可
        if dataBaseTool.dataBase?.open() == false {
            print("打开数据库失败")
            return
        }
        
        let result = dataBaseTool.dataBase?.executeQuery("select * from Borrow_Table where UserName = ? and BookID = ?", withArgumentsIn: [userName,bookID])
        
        //判断是否有结果
        if result?.next() != false {
            //有记录
            let borrowNumber = result?.int(forColumn: "borrowNumber")
            
            if dataBaseTool.updateTable(sql: "update Borrow_Table set borrowNumber = ? where UserName = ? and BookID = ?", arguments: [(borrowNumber!+1),userName,bookID]) == false {
                print("更新已有记录失败")
            }
            
        }else{
            //将借书信息添加到表中
            if dataBaseTool.updateTable(sql: "insert into Borrow_Table values (?,?,?)", arguments: [userName,bookID,1]) == false {
                UIView.alertMessage(title: "注意", message: "借书失败", preferredStyle: .alert, target: self, compelete: nil)
            }
        }
        
        dataBaseTool.dataBase?.close()
        
        //更新数据源并刷新表格
        self.queryBooksFromDataBase()
        tableView.reloadData()
        
        
    }

}
