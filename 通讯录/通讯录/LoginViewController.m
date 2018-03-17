//
//  LoginViewController.m
//  通讯录
//
//  Created by William on 2018/1/2.
//  Copyright © 2018年 William. All rights reserved.
//

#import "LoginViewController.h"
#import "UsersViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UISwitch *remPwd;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    //给文本框设置监听器
    [self.userName addTarget:self action:@selector(BeginInput) forControlEvents:UIControlEventEditingChanged];
    [self.passWord addTarget:self action:@selector(BeginInput) forControlEvents:UIControlEventEditingChanged];
    //当输入框都有值的时候才可以点击登录按钮
    //手动判断是否有值
    [self BeginInput];
}
- (void)BeginInput{
    if(self.userName.text.length == 0 || self.passWord.text.length == 0){
        self.loginBtn.enabled = NO;
    }else{
        self.loginBtn.enabled = YES;
    }
}
//设置记住密码开关和自动登录开关业务逻辑
- (IBAction)touchRemPwd:(UISwitch *)sender {
    
    if(self.remPwd.isOn == NO){
        [self.autoLogin setOn:NO animated:YES];
    }
    
}
- (IBAction)touchAutoLogin:(UISwitch *)sender {
    if(self.remPwd.isOn == NO && self.autoLogin.isOn == YES){
        [self.remPwd setOn:YES animated:YES];
    }
}

//点击登录按钮跳转界面
- (IBAction)loginBtnClicked:(UIButton *)sender {
    UsersViewController *usersVC = [[UsersViewController alloc] init];
    [usersVC setName:self.userName.text];
    [self.navigationController pushViewController:usersVC animated:YES];
    
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
