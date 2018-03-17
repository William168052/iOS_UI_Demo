//
//  UsersViewController.m
//  通讯录
//
//  Created by William on 2018/1/2.
//  Copyright © 2018年 William. All rights reserved.
//

#import "UsersViewController.h"
#import "LoginViewController.h"
#import "AddViewController.h"
#import "ContactPerson.h"
#import "EditViewController.h"
@interface UsersViewController ()<AddViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray<ContactPerson *> *contactArray;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@-的通讯录",self.name];
    //添加注销按钮
    UIBarButtonItem *logOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = logOutBtn;
    //添加添加按钮
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadData" object:nil];
}

- (void)reloadTableView{
    [self.tableView reloadData];
}

//懒加载联系人数组
- (NSMutableArray *)contactArray{
    if(_contactArray == nil){
        _contactArray = [NSMutableArray array];
    }
    return _contactArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LogoutMethod/addMethod

- (void)logOut{
    //设置一个弹框提醒
    UIAlertController *AC = [UIAlertController alertControllerWithTitle:@"确定要退出吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加按钮
    UIAlertAction *permitAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    [AC addAction:permitAct];
    [AC addAction:cancelAct];
    //显示弹框
    [self presentViewController:AC animated:YES completion:nil];
    
//    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}
//添加联系人事件
- (void)addContact{
    AddViewController *addVC = [[AddViewController alloc] init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - AddViewControllerDelegate


- (void)addViewController:(AddViewController *)addVC contactPerson:(ContactPerson *)contactPerson{
    //将接收到的数据放进数组
    [self.contactArray addObject:contactPerson];
    //刷新表格
    [self.tableView reloadData];
    //去除多余的表格线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    NSLog(@"%@,%@",contactPerson.name,contactPerson.phoneNum);
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contactArray.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CELLID";
    //从缓存池中取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //若没有则新建
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //取出当前行模型
    ContactPerson *cp = self.contactArray[indexPath.row];
    cell.textLabel.text = cp.name;
    cell.detailTextLabel.text = cp.phoneNum;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactPerson *cp = self.contactArray[indexPath.row];
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.contactPerson = cp;
    //跳转
    [self.navigationController pushViewController:editVC animated:YES];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
