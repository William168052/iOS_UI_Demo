//
//  MainViewController.m
//  模仿QQ界面实现抽屉效果
//
//  Created by William on 06/01/2018.
//  Copyright © 2018 William. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderView.h"
@interface MainViewController ()

//数据数组
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor blueColor];
    
#pragma mark - backgroundView/headerView
    
    //创建背景的view(背景得单独创建)
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreeW, 84)];
    bgView.image = [UIImage imageNamed:@"headerView_background_"];
    //创建HeadView
    HeaderView *headView =[HeaderView headerViewWithFrame:CGRectMake(0, 0, ScreeW, 84)];
    //传入引用
    headView.targetVC = self;
    //tableView距顶部无间距
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.tableHeaderView = bgView;
    [self.view addSubview:headView];
//    NSLog(@"%@",NSStringFromCGRect(headView.frame));
    
    
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //添加TabBar
    UITabBar *bar = [[UITabBar alloc] initWithFrame:CGRectMake(0, ScreeH - 49, ScreeW, 64)];
    UITabBarItem *itemL = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@""] tag:0];
    UITabBarItem *itemC = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@""] tag:1];
    UITabBarItem *itemR = [[UITabBarItem alloc] initWithTitle:@"动态" image:[UIImage imageNamed:@""] tag:2];

    NSArray *itemArr = @[itemL,itemC,itemR];
    [bar setItems:itemArr];
    
    [self.view addSubview:bar];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
