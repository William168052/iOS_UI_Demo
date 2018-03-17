//
//  EditViewController.m
//  通讯录
//
//  Created by William on 2018/1/3.
//  Copyright © 2018年 William. All rights reserved.
//

#import "EditViewController.h"
#import "ContactPerson.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (strong, nonatomic) UIBarButtonItem *editBtn;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置数据和状态
    self.name.text = self.contactPerson.name;
    self.phoneNum.text = self.contactPerson.phoneNum;
    self.name.enabled = NO;
    self.phoneNum.enabled = NO;
    
    //设置编辑按钮
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClick)];
    self.editBtn = editBtn;
    self.navigationItem.rightBarButtonItem =editBtn;
    

}

- (void)editBtnClick{
    if([self.editBtn.title isEqualToString:@"编辑"]){
        self.name.enabled = YES;
        self.phoneNum.enabled = YES;
        //让phoneNum成为第一响应者
        [self.phoneNum becomeFirstResponder];
        self.editBtn.title = @"保存";
        //添加取消按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEditing)];
    }else if([self.editBtn.title isEqualToString:@"保存"]){
        //将模型里的数据修改
        self.contactPerson.name = self.name.text;
        self.contactPerson.phoneNum = self.phoneNum.text;
        //通知UsersViewController刷新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil userInfo:nil];
        //跳转界面
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//取消编辑
- (void)cancelEditing{
    [self.view endEditing:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.name.enabled = NO;
    self.phoneNum.enabled = NO;
    self.editBtn.title = @"编辑";
    //恢复之前的数据
    self.name.text = self.contactPerson.name;
    self.phoneNum.text = self.contactPerson.phoneNum;
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
