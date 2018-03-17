//
//  AddViewController.m
//  通讯录
//
//  Created by William on 2018/1/3.
//  Copyright © 2018年 William. All rights reserved.
//

#import "AddViewController.h"
#import "ContactPerson.h"
//#import "UsersViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加联系人";
    //添加监听器
    [self.name addTarget:self action:@selector(inputInfo) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNum addTarget:self action:@selector(inputInfo) forControlEvents:UIControlEventEditingChanged];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //判断添加按钮状态
    [self inputInfo];
}

- (void)inputInfo{
//    self.addBtn.enabled = self.name.text.length && self.phoneNum.text.length;
    if(self.name.text.length == 0 || self.phoneNum.text.length == 0){
        self.addBtn.enabled = NO;
    }else{
        self.addBtn.enabled = YES;
    }
}

//添加按钮点击事件
- (void)addBtnClick{
    //传值
    if(self.delegate != nil){
        ContactPerson *cp = [ContactPerson personWithName:self.name.text andPhoneNumber:self.phoneNum.text];
//        UsersViewController *userVC = (UsersViewController *)self.delegate;
//        userVC.contactPerson = cp;
        [self.delegate addViewController:self contactPerson:cp];
    }
//    跳转
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
