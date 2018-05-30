//
//  Attributes.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

enum UserIdentifier : String {
    case normalUser = "normalUser"
    case administrator = "administrator"
}

//弹框提示
extension UIView{
    static func alertMessage(title:String,message:String,preferredStyle:UIAlertControllerStyle,target:UIViewController,compelete:(()->Void)?) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle:preferredStyle)
        
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        
        
        
        target.present(alertVC, animated: true){
            if compelete != nil {
                compelete!()
            }
        }
        
    }

}



