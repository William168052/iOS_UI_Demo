//
//  ListTableViewCell.m
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)listTableViewCell :(UITableView *)tableView :(NSString *)identifier{
        //注册cell
        [tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        ListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ListTableViewCell" owner:nil options:nil] firstObject];
    return cell;
}

@end
