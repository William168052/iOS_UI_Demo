//
//  BasicViewController.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    @IBOutlet weak var registBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图书借阅管理系统"
        self.view.layer.contents = UIImage.init(named: "bgImg")?.cgImage as Any
        //设置圆角
        self.registBtn.layer.cornerRadius = 10
        self.loginBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userLogin(_ sender: UIButton) {
        self.navigationController?.pushViewController(LoginViewController.init(), animated: true)
    }
    
    
    
    @IBAction func regist(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegistViewController.init(), animated: true)
    }
    
    
   

}
