//
//  ManageBooksViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/17.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class ManageBooksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataBaseTool = ZWTSQLiteTool.shareInstance
    
    var bookArray : [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //准备数据
        self.queryBooksFromDataBase()
        
        //设置tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    
    func queryBooksFromDataBase() {
        self.bookArray = Array<Book>.init()
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
                self.bookArray?.append(Book.init(id: id!, name: name!, number: Int(number!), author: author!, publicName: pub!))
            }
        }
        self.dataBaseTool.dataBase?.close()
    }
    
    @IBAction func addBook(_ sender: UIButton) {
        //弹出界面输入
        let alertV = UIAlertController.init(title: "添加书籍", message: nil, preferredStyle: .alert)
        
        for index in 0..<Book.properties.count {
            alertV.addTextField { (textField) in
                textField.placeholder = Book.properties[index]
            }
        }
        
        alertV.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            let textF = alertV.textFields
            
            if let textF = textF {
                var book : Book?
                //属性
                var ID : String?
                var name : String?
                var number : Int?
                var author : String?
                var pub : String?
                for index in 0..<textF.count {
                    let tf = textF[index]
                    switch tf.placeholder {
                    case "书籍编号":
                        ID = tf.text
                    case "书名":
                        name = tf.text
                    case "书籍数量":
                        number = (tf.text! as NSString).integerValue
                    case "作者":
                        author = tf.text
                    case "出版社":
                        pub = tf.text
                    default :
                        break
                    }
                }
                book = Book.init(id: ID!, name: name!, number: number!, author: author!, publicName: pub!)

                let flag = self.dataBaseTool.updateTable(sql: "insert into Book_Table values (?,?,?,?,?)", arguments: [ID!,name!,number!,author!,pub!])
                if flag == false {
                    UIView.alertMessage(title: "警告", message: "添加图书失败", preferredStyle: .alert, target: self, compelete: nil)
                }else{
                    //将书籍添加到array中
                    self.bookArray?.append(book!)
                    //局部刷新cell
                    self.tableView.insertRows(at: [IndexPath.init(row: (self.bookArray?.count)! - 1, section: 0)], with: .left)
                }
                
            }
            
            
        }))
        alertV.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: nil))
        self.present(alertV, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.bookArray?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BookTableViewCell
        if cell == nil {
            cell = BookTableViewCell.tableViewCell(tableView: tableView, identifier: identifier)
        }
        let book : Book? = self.bookArray?[indexPath.row]
        cell?.IDLabel.text = book?.bookID
        cell?.NameLabel.text = book?.bookName
        cell?.authorLabel.text = book?.bookAuthor
        cell?.publicLabel.text = book?.bookPublic
        cell?.residueBook.text = String.init(format: "剩余%d本", (book?.bookNumber)!)
        cell?.borrowBtn.isHidden = true
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action_1 = UITableViewRowAction.init(style: .destructive, title: "删除") { (rowAction, indexPath) in
            //弹框确认
            let alert = UIAlertController.init(title: "确认删除此书籍吗", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认", style: .destructive, handler: { (action) in
                //从借阅记录中删除
                let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
                let ID = cell.IDLabel.text
                if self.dataBaseTool.deleteFromTable(sql: "delete from Book_Table where BookID = ?", arguments: [ID!]) == false {
                    print("删除书籍失败")
                    
                }else{
                    
                    //刷新表格以及数据源
                    self.queryBooksFromDataBase()
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        return [action_1]
    }

    

}
