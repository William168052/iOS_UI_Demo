//
//  LoginViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var RemPwdSwitch: UISwitch!
    @IBOutlet weak var autoLogin: UISwitch!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var identifier: UISegmentedControl!
    let dataBaseTool = ZWTSQLiteTool.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(popVC))
    
    }
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //清空
        self.userName.text = ""
        self.userPwd.text = ""
    }
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        //去数据库上验证
        let selectedId = self.identifier.titleForSegment(at: self.identifier.selectedSegmentIndex)!
        let id : UserIdentifier?
        if selectedId == "用户" {
            id = UserIdentifier.normalUser
        }else{
            id = UserIdentifier.administrator
        }
        let user = User.init(userName: self.userName.text!, passWord: self.userPwd.text!, identifier: (id?.rawValue)!)
        self.checkUserInfoFromDataBase(user: user)
    }
    
    func checkUserInfoFromDataBase(user:User?) {
        
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
            return
        }
        
        if let userData = user {
            let result = self.dataBaseTool.dataBase?.executeQuery("select passWord as pwd from User_Table where UserName is ? and identifier is ? ", withArgumentsIn: [userData.userName!,userData.identifier!])
            if result != nil {
                var CorrectPwd  : String?
                while (result?.next())! {
                    CorrectPwd = result?.string(forColumn: "pwd")
                }
                //进行比较
                if userData.passWord == CorrectPwd {
                    //验证成功
                    self.dataBaseTool.dataBase?.close()
                    // MARK:登录成功
                    if user?.identifier == UserIdentifier.normalUser.rawValue {
                        //创建普通用户单例
                        User.login(userName: userName.text!, passWord: userPwd.text!, identifier: UserIdentifier.normalUser.rawValue)
                        //登录普通用户界面
                        let vc = BasicUserViewController.init()
                        vc.identifier = UserIdentifier.normalUser
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        //创建管理员单例
                        User.login(userName: userName.text!, passWord: userPwd.text!, identifier: UserIdentifier.administrator.rawValue)
                        //登录管理员界面
                        let vc = BasicUserViewController.init()
                        vc.identifier = UserIdentifier.administrator
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                }else{
                    //验证失败
                    self.dataBaseTool.dataBase?.close()
                    //弹框提示
                    let alertVC = UIAlertController.init(title: "警告", message: "用户名或密码错误", preferredStyle: .alert)
                    
                    alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
                    
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
}
