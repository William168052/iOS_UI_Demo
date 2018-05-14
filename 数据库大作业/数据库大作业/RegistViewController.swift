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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }
    

    @IBAction func registBtnClicked(_ sender: UIButton) {
        //取消编辑模式
        self.view.window?.endEditing(true)
        
        
        if !(self.userName.text?.isEmpty)! &&
            !(self.userPwd.text?.isEmpty)! &&
            self.userPwd.text == self.confirmTextF.text {
            
            //将注册信息写入数据库并提示注册成功
            let selectedId = self.identifier.titleForSegment(at: self.identifier.selectedSegmentIndex)!
            let id : UserIdentifier?
            if selectedId == "用户" {
                id = UserIdentifier.normalUser
            }else{
                id = UserIdentifier.administrator
            }
            let user = User.init(userName: self.userName.text!, passWord: self.userPwd.text!, identifier: UserIdentifier(rawValue: id!.rawValue)!)
            
            self.registToDataBase(withData: user, completion: {
                // MARK:注册成功并登录
                
            })
            
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
    func registToDataBase(withData data:User?,completion:()->Void){
        
    }
}
