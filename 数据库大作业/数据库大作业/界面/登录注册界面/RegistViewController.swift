//
//  RegistViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var identifier: UISegmentedControl!
    
    @IBOutlet weak var confirmTextF: UITextField!
    @IBOutlet weak var inputTextF: UITextField!
    @IBOutlet weak var registBtn: UIButton!
    
    //数据库
    let dataBaseTool = ZWTSQLiteTool.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //如果没有表新建一张表
//        let flag = self.dataBaseTool.createTable(sql: "create table if not exists User_Table(UserName text primary key not null,passWord text not null,identifier text not null)")
//        if flag == false {
//            print("建表失败")
//        }
        self.title = "注册"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //清空
        self.userName.text = ""
        self.userPwd.text = ""
        self.confirmTextF.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }
    
    @IBAction func inputName(_ sender: UITextField) {
        if self.checkUserNameIsDumplicate(name: sender.text!) == true {
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor.red.cgColor
        }else{
            sender.layer.borderWidth = 0
            sender.layer.borderColor = UIColor.clear.cgColor
        }
    }
    // MARK:检查用户名是否重名
    func checkUserNameIsDumplicate(name:String)->Bool{
        // 查询数据库
        if !((self.dataBaseTool.dataBase?.open())!) {
            print("数据库打开失败")
            return false
        }
        
        let result = self.dataBaseTool.dataBase?.executeQuery("select count(*) as resultCount from User_Table where UserName is ?", withArgumentsIn: [name])
        var count : Int32?
//        print(result)
        while (result?.next())! {
            count = result?.int(forColumn: "resultCount")
        }
        
        if count == 0 {
            //没有重名
            self.dataBaseTool.dataBase?.close()
            return false
        }else{
            self.dataBaseTool.dataBase?.close()
            return true
        }
        
    }
    

    @IBAction func registBtnClicked(_ sender: UIButton) {
        //取消编辑模式
        self.view.window?.endEditing(true)
        
        
        if !(self.userName.text?.isEmpty)! &&
            !(self.userPwd.text?.isEmpty)! &&
            self.userPwd.text == self.confirmTextF.text &&
            !self.checkUserNameIsDumplicate(name: self.userName.text!){
            
            //将注册信息写入数据库并提示注册成功
            let selectedId = self.identifier.titleForSegment(at: self.identifier.selectedSegmentIndex)!
            let id : UserIdentifier?
            if selectedId == "用户" {
                id = UserIdentifier.normalUser
            }else{
                id = UserIdentifier.administrator
            }
            let user = User.init(userName: self.userName.text!, passWord: self.userPwd.text!, identifier: (id?.rawValue)!)
            
           
                // MARK:注册成功并登录
            self.registToDataBase(withData: user) { (isSucceed) in
                if isSucceed == false {
                    print("注册失败")
                }else{
                    let mainVC = LoginViewController.init()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                    print("注册成功")
                }
            }
            
        }else{
            //弹框提示
            let alertVC = UIAlertController.init(title: "警告", message: "输入有误", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    //确认密码
    @IBAction func confirmPwd(_ sender: UITextField) {
        if sender.text != self.inputTextF.text {
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor.red.cgColor
        }else{
            sender.layer.borderWidth = 0
            sender.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBAction func beginInputPwd(_ sender: UITextField) {

    }
    //输入
    @IBAction func inputPwd(_ sender: UITextField) {
        self.confirmTextF.text = ""
        if sender.text != "" {
            self.confirmTextF.isEnabled = true
        }else{
            self.confirmTextF.isEnabled = false
        }
    }
    
    //将注册信息提交数据库
    func registToDataBase(withData data:User?,completion: @escaping (_ result:Bool)->Void){
        
        if let userData = data {
            let user_name = userData.userName
            let user_passWorld = userData.passWord
            let user_identifier = userData.identifier
            let flag = self.dataBaseTool.updateTable(sql: "insert into User_Table values (?,?,?)", arguments: [user_name!,user_passWorld!,user_identifier!])
            if flag == false {
                completion(false)
            }else{
                completion(true)
            }
        }else{
            completion(false)
        }
        
    }
}
