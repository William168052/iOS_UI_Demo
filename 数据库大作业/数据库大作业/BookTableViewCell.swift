//
//  BookTableViewCell.swift
//  数据库大作业
//
//  Created by William on 2018/5/17.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate {
    func bookTableViewCell(didClickBorrowButton cell:BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publicLabel: UILabel!
    @IBOutlet weak var borrowBtn: UIButton!
    @IBOutlet weak var residueBook: UILabel!
    
    //代理
    var delegate : BookTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func tableViewCell(tableView : UITableView,identifier : String)->BookTableViewCell?{
        //注册cell
        tableView.register(UINib.init(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        //创建cell并返回
        let cell : BookTableViewCell? = (Bundle.main.loadNibNamed("BookTableViewCell", owner: nil, options: nil)?.first as? BookTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
    static func tableViewCell(tableView : UITableView)->BookTableViewCell?{
        //创建cell并返回
        let cell : BookTableViewCell? = (Bundle.main.loadNibNamed("BookTableViewCell", owner: nil, options: nil)?.first as? BookTableViewCell)!
        
        
        if let cell = cell{
            return cell
        }
        return nil
    }
    
    @IBAction func borrowBtnClick(_ sender: UIButton) {
        self.delegate?.bookTableViewCell(didClickBorrowButton: self)
    }
    
}
