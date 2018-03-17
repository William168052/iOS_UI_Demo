//
//  ListTableViewCell.h
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recLength;

+(instancetype)listTableViewCell :(UITableView *)tableView :(NSString *)identifier;

@end
