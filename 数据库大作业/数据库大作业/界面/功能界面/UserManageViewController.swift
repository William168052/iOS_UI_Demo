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
    
    func queryUsersFromDataBase() {
        self.userArray = Array<User>.init()
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
        }
        let result = self.dataBaseTool.dataBase?.executeQuery("select * from User_Table", withArgumentsIn: [])
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
        self.queryUsersFromDataBase()
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

    
}
