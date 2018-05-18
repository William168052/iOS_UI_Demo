//
//  BorrowBookViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BorrowBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var booksArray : [Book]? = Array<Book>.init()
    
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
        let book : Book? = self.booksArray?[indexPath.row]
        cell?.IDLabel.text = book?.bookID
        cell?.NameLabel.text = book?.bookName
        cell?.authorLabel.text = book?.bookAuthor
        cell?.publicLabel.text = book?.bookPublic
        cell?.residueBook.text = String.init(format: "剩余%d本", (book?.bookNumber)!)
        return cell!
    }

}
