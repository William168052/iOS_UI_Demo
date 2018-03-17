//
//  ProjectTableViewCell.h
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectTableViewCell;
@protocol ProjectTableViewCellDelegate <NSObject>
@optional
//传出商品名称和自己
-(void)ProjectTableViewCellSelectedObjectName :(NSString *)objName tableViewCell :(ProjectTableViewCell *)cell currentClickButton :(UIButton *)button;
//传出所有属性
-(void)projectTableViewCell :(ProjectTableViewCell *)cell WithName :(NSString *)productName unitName :(NSString *)unit productNumber :(NSNumber *)number andTotalPrice :(NSNumber *)price;

//通知代理做事情
-(void)projectTableViewCellAnnounceDelegateScroll :(ProjectTableViewCell *)cell;

-(void)projectTableViewCellRemoveSubject :(NSInteger)index tableViewCell :(ProjectTableViewCell *)cell;

-(void)projectTableViewCellRemoveTableViewCell :(ProjectTableViewCell *)cell;

//传出改变的值

-(void)ProjectTableViewCellProductNameValueChanged :(NSString *)name inTableViewCell :(ProjectTableViewCell *)cell;
-(void)ProjectTableViewCellUnitNameValueChanged :(NSString *)name inTableViewCell :(ProjectTableViewCell *)cell;
-(void)ProjectTableViewCellNumberValueChanged :(NSNumber *)number inTableViewCell :(ProjectTableViewCell *)cell;
-(void)ProjectTableViewCellPriceValueChanged :(NSNumber *)price inTableViewCell :(ProjectTableViewCell *)cell;


@end

@interface ProjectTableViewCell : UITableViewCell
@property(nonatomic,strong)id<ProjectTableViewCellDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIButton *addNameBtn;
//@property (weak, nonatomic) IBOutlet UIButton *unitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *addNameImg;
@property (weak, nonatomic) IBOutlet UIImageView *addUnitImg;
@property (weak, nonatomic) IBOutlet UIButton *productName;
@property (weak, nonatomic) IBOutlet UIButton *unitName;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (nonatomic,assign)NSInteger indexAtTableView;

+(instancetype)projectTableViewCellWithTableView :(UITableView *)tableView;
+(instancetype)projectTableViewCellWithTableView :(UITableView *)tableView identifier :(NSString *)identifier;
@end
