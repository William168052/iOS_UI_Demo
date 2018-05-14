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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let user = User.init(userName: self.userName.text!, passWord: self.userPwd.text!, identifier: UserIdentifier(rawValue: id!.rawValue)!)
        if checkUserInfoFromDataBase(user: user) == true {
            // MARK:登录成功
            
        }
    }
    
    func checkUserInfoFromDataBase(user:User?)->Bool {
        return true
    }
}
