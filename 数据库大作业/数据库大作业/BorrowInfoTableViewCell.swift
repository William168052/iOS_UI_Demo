//
//  BorrowInfoTableViewCell.swift
//  数据库大作业
//
//  Created by William on 2018/5/30.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class BorrowInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookIDLabel: UILabel!
    @IBOutlet weak var bookNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static func tableViewCell(tableView : UITableView,identifier : String)->BorrowInfoTableViewCell?{
        //注册cell
        tableView.register(UINib.init(nibName: "BorrowInfoTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        //创建cell并返回
        let cell : BorrowInfoTableViewCell? = (Bundle.main.loadNibNamed("BorrowInfoTableViewCell", owner: nil, options: nil)?.first as? BorrowInfoTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
    static func tableViewCell(tableView : UITableView)->BorrowInfoTableViewCell?{
        //创建cell并返回
        let cell : BorrowInfoTableViewCell? = (Bundle.main.loadNibNamed("BorrowInfoTableViewCell", owner: nil, options: nil)?.first as? BorrowInfoTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
}
