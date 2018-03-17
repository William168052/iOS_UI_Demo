//
//  ProjectTableViewCell.m
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "CLAlertView.h"
#import "Product.h"
#import "NSString+NSStringFormat.h"
#import "PlistManager.h"
@interface ProjectTableViewCell()<CLAlertViewDelegate>

@property (nonatomic,strong)NSMutableArray *productArray;
@property (nonatomic,strong)NSMutableArray *unitArray;
@property (nonatomic,strong)CLAlertView *productButtonView;
@property (nonatomic,strong)CLAlertView *unitView;
@property (nonatomic,strong)UIButton *currentClickButton;


@end
@implementation ProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)projectTableViewCellWithTableView :(UITableView *)tableView{
    
    ProjectTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ProjectTableViewCell" owner:nil options:nil] firstObject];
    
    
    return cell;
}

+(instancetype)projectTableViewCellWithTableView :(UITableView *)tableView identifier :(NSString *)identifier{
    [tableView registerNib:[UINib nibWithNibName:@"ProjectTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    ProjectTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ProjectTableViewCell" owner:nil options:nil] firstObject];
    return cell;
}


-(NSArray *)productArray{
    if(_productArray == nil){
        _productArray = [NSMutableArray arrayWithArray:[PlistManager readPlistFileWithName:@"products"]];
    }
    return _productArray;
}

-(NSArray *)unitArray{
    if(_unitArray == nil){
        _unitArray = [NSMutableArray arrayWithArray:[PlistManager readPlistFileWithName:@"units"]];
    }
    return _unitArray;
}

-(CLAlertView *)unitView{
    if(_unitView == nil){
//        _unitView =
        _unitView = [CLAlertView globeBottomView];
        _unitView.delegate = self;
        _unitView.hlightButton = 0;
        _unitView.colorStr = [UIColor orangeColor];
        _unitView.titleArray = self.unitArray;
        _unitView.title = @"单位";
    }
    return _unitView;
}

-(CLAlertView *)productButtonView{
    if(_productButtonView == nil){
        _productButtonView = [CLAlertView globeBottomView];
        _productButtonView.delegate = self;
        _productButtonView.hlightButton = 0;
        _productButtonView.colorStr = [UIColor blackColor];
        _productButtonView.titleArray = self.productArray;
        _productButtonView.title = @"商品";
    }
    return _productButtonView;
}


- (IBAction)productBtnClicked:(UIButton *)sender {
    
    [self.productButtonView show];
    self.currentClickButton = sender;
    //收起键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (IBAction)unitBtnClicked:(UIButton *)sender {
    [self.unitView show];
    self.currentClickButton = sender;
    //收起键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (IBAction)textfiledInputed:(UITextField *)sender{
    [self.delegate projectTableViewCellAnnounceDelegateScroll:self];
}

- (IBAction)finishInput:(UITextField *)sender {
    ProjectTableViewCell *cell = (ProjectTableViewCell *)sender.superview.superview;
    if(sender == cell.number){
        [self.delegate ProjectTableViewCellNumberValueChanged:[NSString formatStringToNSNumberObject:sender.text] inTableViewCell:cell];
        
    }else if(sender == cell.price){
        [self.delegate ProjectTableViewCellPriceValueChanged:[NSNumber numberWithDouble:sender.text.doubleValue] inTableViewCell:cell];
    }
}



//传值代理
-(void)globeBottomViewButtonClick:(NSInteger)index{
    if (self.currentClickButton == self.productName){

        [self.delegate ProjectTableViewCellProductNameValueChanged:[self.productArray objectAtIndex:index] inTableViewCell:self];
    }else if(self.currentClickButton == self.unitName){

        [self.delegate ProjectTableViewCellUnitNameValueChanged:[self.unitArray objectAtIndex:index] inTableViewCell:self];
    }

}







@end
