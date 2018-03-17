//
//  BillListTableViewCell.h
//  ChargeBook
//
//  Created by William on 2018/2/24.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillListTableViewCell;



@interface BillListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *outOrIn;
@property (weak, nonatomic) IBOutlet UILabel *price;

+(instancetype)billListTableViewCellWithTableView :(UITableView *)tableView identifier :(NSString *)identifier;

@end
