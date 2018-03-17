//
//  SettingViewController.m
//  记账本
//
//  Created by William on 2018/2/16.
//  Copyright © 2018年 William. All rights reserved.
//

#import "SettingViewController.h"
#import "PlistManager.h"
@class Product;


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray<NSString *> *productArray;
@property (nonatomic,strong)NSMutableArray<NSString *> *unitArray;
@property (nonatomic,strong)UISegmentedControl *segment;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"设置产品",@"设置单位"]];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    [segment addTarget:self action:@selector(segmentClicked) forControlEvents:UIControlEventValueChanged];
    self.segment = segment;
    
    
    //添加按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProject)];
    
    
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(turnBack)];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}


//懒加载
-(NSMutableArray *)unitArray{
    if(_unitArray == nil){
        _unitArray = [NSMutableArray arrayWithArray:[PlistManager readPlistFileWithName:@"units"]];
    }
    return _unitArray;
}

-(NSMutableArray *)productArray{
    if(_productArray == nil){
        _productArray = [NSMutableArray arrayWithArray:[PlistManager readPlistFileWithName:@"products"]];
    }
    return _productArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//监听动作方法

-(void)addProject{
    if(self.segment.selectedSegmentIndex == 0){
        [self alertViewWithTitle:@"添加商品"];
    }else{
        [self alertViewWithTitle:@"添加单位"];
    }
    
}

-(void)turnBack{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)segmentClicked{
    [self.tableView reloadData];
}



//弹框
-(void)alertViewWithTitle :(NSString *)title{
    //弹框
    UIAlertController *recAlert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [recAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入名称";
    }];
    //确定按钮
    UIAlertAction *okAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(self.segment.selectedSegmentIndex == 0){
            //修改数组数据
            [self.productArray insertObject:recAlert.textFields.lastObject.text atIndex:0];
            //重新写入文件
            [PlistManager writePlistFileWithData:self.productArray andFileName:@"products"];
            //局部刷新数据
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }else{
            //修改数组数据
            [self.unitArray insertObject:recAlert.textFields.lastObject.text atIndex:0];
            //重新写入文件
            [PlistManager writePlistFileWithData:self.productArray andFileName:@"units"];
            [[NSArray arrayWithArray:self.unitArray] writeToFile:FilePath(@"units") atomically:YES];
            
            //局部刷新数据
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }

        
    }];
    
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [recAlert addAction:okAct];
    [recAlert addAction:cancelAct];
    [self presentViewController:recAlert animated:YES completion:nil];
}



#pragma-mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.segment.selectedSegmentIndex == 0){
        //选中第一个
        return self.productArray.count;
    }else{
        //选中第二个
        return self.unitArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if(self.segment.selectedSegmentIndex == 0){
        cell.textLabel.text = [self.productArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.unitArray objectAtIndex:indexPath.row];
    }
    
    //添加轻扫手势
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    [tableView addGestureRecognizer:gesture];
    
    cell.userInteractionEnabled = NO;
    
    
    
    return cell;
}




//轻扫手势
-(void)rightSwipe{
    [self.tableView setEditing:NO animated:YES];
}


//左滑删除
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //点击了删除按钮
        if(self.segment.selectedSegmentIndex == 0){
            [self.productArray removeObject:[self.productArray objectAtIndex:indexPath.row]];
            //重新写入文件
            [PlistManager writePlistFileWithData:self.productArray andFileName:@"products"];
        }else{
            [self.unitArray removeObject:[self.unitArray objectAtIndex:indexPath.row]];
            //重新写入文件
            [PlistManager writePlistFileWithData:self.unitArray andFileName:@"units"];
        }
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [self.tableView setEditing:NO animated:YES];
    }];
    return @[deleteRowAction];
    
    
}

@end
