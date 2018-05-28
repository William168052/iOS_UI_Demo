//
//  UserManageViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/24.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class UserManageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userArray : [User]?
    
    let dataBaseTool = ZWTSQLiteTool.shareInstance
    
    var currentDisplayItem : UserIdentifier = UserIdentifier.normalUser
    
    @IBOutlet weak var administratorBtn: UIButton!
    
    @IBOutlet weak var userBtn: UIButton!
    
    @IBAction func adminSelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.userBtn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        self.currentDisplayItem = UserIdentifier.administrator
        //刷新数据
        self.queryUsersFromDataBase(displayItem: self.currentDisplayItem)
        self.tableView.reloadData()
        
        
    }
    @IBAction func userBtnSelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.administratorBtn.backgroundColor = #colorLiteral(red: 0.9279624048, green: 0.9279624048, blue: 0.9279624048, alpha: 1)
        self.currentDisplayItem = UserIdentifier.normalUser
        //刷新数据
        self.queryUsersFromDataBase(displayItem: self.currentDisplayItem)
        self.tableView.reloadData()
    }
    func queryUsersFromDataBase(displayItem:UserIdentifier) {
        self.userArray = Array<User>.init()
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
        }
        let result = self.dataBaseTool.dataBase?.executeQuery("select * from User_Table where identifier == ?", withArgumentsIn: [displayItem.rawValue])
        if result != nil {
            while (result?.next())! {
                let name = result?.string(forColumn: "UserName")
                let pwd = result?.string(forColumn: "passWord")
                let id = result?.string(forColumn: "identifier")
                self.userArray?.append(User.init(userName: name!, passWord: pwd!, identifier: id!))
            }
        }
        self.dataBaseTool.dataBase?.close()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //准备数据
        self.queryUsersFromDataBase(displayItem: self.currentDisplayItem)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.userArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SettingTableViewCell
        
        if cell == nil {
            cell = SettingTableViewCell.tableViewCell(tableView: tableView, identifier: identifier)
        }
        let user = self.userArray![indexPath.row]
        var iconName : String?
        if user.identifier == UserIdentifier.administrator.rawValue {
            iconName = "administrator"
        }else{
            iconName = "user"
        }
        if let iconName = iconName{
            cell?.iconView.image = UIImage.init(named: iconName)
        }
        
        cell?.mainTitle.text = user.userName
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let action_1 = UITableViewRowAction.init(style: .destructive, title: "删除") { (rowAction, indexPath) in
                //弹框确认
                let alert = UIAlertController.init(title: "确认删除此用户吗", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "确认", style: .destructive, handler: { (action) in
                    //从用户中删除
                    let cell = tableView.cellForRow(at: indexPath) as! SettingTableViewCell
                    let name = cell.mainTitle.text
                    if self.dataBaseTool.deleteFromTable(sql: "delete from User_Table where UserName = ?", arguments: [name!]) == false {
                        print("删除用户失败")
                        
                    }else{
                        
                        //刷新表格以及数据源
                        self.queryUsersFromDataBase(displayItem: self.currentDisplayItem)
                        tableView.deleteRows(at: [indexPath], with: .left)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
            return [action_1]
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.currentDisplayItem == UserIdentifier.normalUser {
            return true
        }else{
            return false
        }
    }


    
}
