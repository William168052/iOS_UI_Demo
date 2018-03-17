//
//  ViewController.m
//  UITableView
//
//  Created by William on 2018/2/5.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;

//数据源DataSource(模型数组)---->字典转模型
@property (nonatomic,strong)NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    //设置数据源和代理
    self.tableView.dataSource = self;
    //代理Delegate
    self.tableView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//tableView里面有几个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *identifier = @"cellID";
    //去缓存池找对应identifier的cell
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    //对cell设置数据
    cell.textLabel.text = @"新录音";
    
    //返回cell
    return cell;
}


@end
