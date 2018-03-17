//
//  BillListTableViewCell.m
//  ChargeBook
//
//  Created by William on 2018/2/24.
//  Copyright © 2018年 William. All rights reserved.
//

#import "BillListTableViewCell.h"
@interface BillListTableViewCell()


@end

@implementation BillListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)billListTableViewCellWithTableView :(UITableView *)tableView identifier :(NSString *)identifier{
    [tableView registerNib:[UINib nibWithNibName:@"BillListTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    BillListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BillListTableViewCell" owner:nil options:nil] firstObject];
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
