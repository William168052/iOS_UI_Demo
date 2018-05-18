//
//  SettingTableViewCell.swift
//  SightWorld
//
//  Created by William on 2018/4/1.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitle: UILabel!
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func tableViewCell(tableView : UITableView,identifier : String)->SettingTableViewCell?{
        //注册cell
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        //创建cell并返回
        let cell : SettingTableViewCell? = (Bundle.main.loadNibNamed("SettingTableViewCell", owner: nil, options: nil)?.first as? SettingTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
    static func tableViewCell(tableView : UITableView)->SettingTableViewCell?{
        //创建cell并返回
        let cell : SettingTableViewCell? = (Bundle.main.loadNibNamed("SettingTableViewCell", owner: nil, options: nil)?.first as? SettingTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
}
