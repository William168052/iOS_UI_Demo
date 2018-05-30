//
//  BasicUserViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/15.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BasicUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var identifier : UserIdentifier?
    
    var userAuthority : [[String:String]]? = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.identifier == UserIdentifier.normalUser {
            self.userAuthority = [["itemName":"借书","icon":"borrowBook"],
                                  ["itemName":"还书","icon":"returnBook"],
                                  ["itemName":"借阅记录","icon":"borrowInfo"]
            ]
        }else if self.identifier == UserIdentifier.administrator {
            self.userAuthority = [["itemName":"图书管理","icon":"book_Manage"],
                                  ["itemName":"用户管理","icon":"user_Manage"],
                                  ["itemName":"借阅记录","icon":"borrowInfo"]
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"
        // MARK:布局界面
        self.setUI()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "退出登录", style: .plain, target: self, action: #selector(logOut))
        // Do any additional setup after loading the view.
        
    }

    @objc func logOut() {
        //释放用户单例
        User.logOut()
        for temp:UIViewController in (self.navigationController?.viewControllers)! {
            if temp.isKind(of: BasicViewController.classForCoder()) {
                self.navigationController?.popToViewController(temp, animated: true)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUI() {
        // MARK:tableView设置
        self.table.delegate = self
        self.table.dataSource = self
        self.table.rowHeight = 50
        self.table.tableFooterView = UIView.init()
        self.table.sectionHeaderHeight = 10
        self.table.sectionFooterHeight = 0
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userAuthority!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellID"
        var cell : SettingTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? SettingTableViewCell
        let dict = self.userAuthority![indexPath.section]
        if cell == nil {
            cell = SettingTableViewCell.tableViewCell(tableView: tableView, identifier: identifier)
        }
        cell?.mainTitle.text = dict["itemName"]
        cell?.iconView.image = UIImage.init(named: dict["icon"]!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = self.userAuthority![indexPath.section]
        var targetVC : UIViewController?
        switch dict["itemName"] {
            
            /*
             *  :普通用户功能
             */
            
        case "借书":
            // MARK:跳转到借书界面
            targetVC = BorrowBookViewController.init()
            break
        case "还书":
            // MARK:跳转到还书界面
            targetVC = BorrowBookViewController.init()
            break
        case "借阅记录":
            // MARK:跳转到借阅查询界面
            targetVC = QueryBorrowInfoVC.init()
            break
            
            /*
             *  管理员功能
             */
        case "图书管理":
            targetVC = ManageBooksViewController.init()
            break
        case "用户管理":
            targetVC = UserManageViewController.init()
            break
        case "借阅记录":
            break
        default :
            break
            
        }
        if let targetVC = targetVC {
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        
    }

}
