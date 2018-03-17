//
//  ViewController.m
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
#import "RecordViewController.h"
#import "RecordFile.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,RecordViewControllerDelegate>

@property (nonatomic,strong)UIView *listV;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    [self setBackground];
    //设置界面元素
    [self setUIElement];
    //设置左边的标题
    [self.navigationItem setTitle:@"录音机"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"moreInfo_button_Default"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(moreInformation)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    //设置tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    //加载数据
    [self.tableView reloadData];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma-mark 懒加载dataArray以及设置dataArray的数据
-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setDataArrayWithData :(id)data{
    [self.dataArray addObject:data];
}

#pragma-mark 设置背景
- (void)setBackground{
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    backgroundImage.image = [UIImage imageNamed:@"background.jpg"];
//
//    //毛玻璃效果
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.frame = [UIScreen mainScreen].bounds;
//    [backgroundImage addSubview:effectView];
//
//    [self.view addSubview:backgroundImage];
    
    
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"background.jpg"].CGImage);
    self.view.backgroundColor = [UIColor clearColor];
    //毛玻璃特效
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    //    [backgroundImage addSubview:effectView];
    [self.view addSubview:effectView];
}

#pragma-mark 设置界面元素
- (void)setUIElement{
    //添加tableView
    UITableView *recList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH * 3 / 4) style:UITableViewStylePlain];
    //设置背景透明
    recList.backgroundColor = [UIColor clearColor];
    self.tableView = recList;
    [self.view addSubview:recList];
    //添加底部的View
    UIView *buttomV = [[UIView alloc] initWithFrame:CGRectMake( 0, recList.frame.size.height, ScreenW, ScreenH / 4)];
    //    buttomV.backgroundColor = [UIColor redColor];
    //添加按钮
    UIButton *recBtn = [[UIButton alloc] initWithFrame:CGRectMake((buttomV.frame.size.width - 80) / 2, (buttomV.frame.size.height - 80) / 2, 80, 80)];
    [recBtn setBackgroundImage:[UIImage imageNamed:@"record_button_Default.png"] forState:UIControlStateNormal];
    [recBtn setBackgroundImage:[UIImage imageNamed:@"record_button_HighLighted.png"] forState:UIControlStateHighlighted];
    [recBtn addTarget:self action:@selector(recordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [buttomV addSubview:recBtn];
    [self.view addSubview:buttomV];
}

#pragma-mark 其他跳转方法
//下拉菜单
- (void)moreInformation{
    if(self.listV == nil){
        self.listV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW - 200, 0, 200, 60)];
        self.listV.backgroundColor = [UIColor whiteColor];
        self.listV.alpha = 0;
        //设置阴影
        self.listV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.listV.layer.shadowOffset = CGSizeMake(-1, 1);
        self.listV.layer.shadowOpacity = 0.8;
//        self.listV.layer.shadowRadius = 0.5;
        [self.view addSubview:self.listV];
    }
    //设置点按逻辑
    if(self.listV.alpha == 0){
        //显示
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.listV.frame;
            frame.origin.y = 64;
            self.listV.frame = frame;
            self.listV.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.listV.frame;
            frame.origin.y = 0;
            self.listV.frame = frame;
            self.listV.alpha = 0;
        }];
    }
    
    
}

- (void)recordButtonClicked{
    RecordViewController *recordVC = [[RecordViewController alloc] init];
    //设置代理
    recordVC.delegate = self;
    [self.navigationController pushViewController:recordVC animated:YES];
    
    
}

#pragma-mark UITableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cellID";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [ListTableViewCell listTableViewCell:tableView :identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    tableView.rowHeight = 90;
    RecordFile *file = [self.dataArray objectAtIndex:indexPath.row];
    cell.mainLabel.text = file.mainName;
    cell.timeLabel.text = file.createTime;
    cell.recLength.text = file.audioLength;
    //设置分割线的位置
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    //设置分割线颜色
    [self.tableView setSeparatorColor:[UIColor grayColor]];
    
    
    
    
    
    return cell;
}

#pragma-mark RecordViewController代理方法
-(void)sendRecordFile:(RecordFile *)file{
    [self.dataArray addObject:file];
    //刷新表格
    [self.tableView reloadData];
}


@end
