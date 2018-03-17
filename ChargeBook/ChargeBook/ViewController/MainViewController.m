//
//  MainViewController.m
//  记账本
//
//  Created by William on 2018/2/13.
//  Copyright © 2018年 William. All rights reserved.
//

#import "MainViewController.h"
#import "AddViewController.h"
#import "SettingViewController.h"
#import "PlistManager.h"
#import "BillList.h"
#import "BillListLibrary.h"
#import "BillListTableViewCell.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,AddViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
//数据源
@property (strong,nonatomic)NSMutableArray<BillListLibrary *> *dataArray;
//添加一条记录
@property (weak, nonatomic) IBOutlet UIButton *addLogData;

@property (weak, nonatomic) IBOutlet UIView *bottomView;




@end

@implementation MainViewController

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.dataArray forKey:@"dataArray"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.dataArray = [aDecoder decodeObjectForKey:@"dataArray"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    
//    //设置导航栏背景
//    
//
//    
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green_bgColor"]];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = NO;
 
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"green_bgColor"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    //设置title以及代理
    self.navigationItem.title = @"蜗蜗记账本";
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting_button_Default"] style:UIBarButtonItemStyleDone target:self action:@selector(settings)];
    [btnItem setWidth:15.0f];
    self.navigationItem.rightBarButtonItem = btnItem;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.bottomView.frame.size.height)];
    
    
    //设置底部的view的背景
    self.bottomView.layer.contents = (id)[UIImage imageNamed:@"buttonV_background"].CGImage;
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    //设置界面跳转
    [self.addLogData addTarget:self action:@selector(addLogDataClick) forControlEvents:UIControlEventTouchUpInside];
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//懒加载dataArray
-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:ArchiveFilePath(@"BillListData")];
        if(array == nil){
            _dataArray = [NSMutableArray array];
        }else{
            _dataArray = array;
        }
    }
    
    return _dataArray;
}

#pragma-mark sortArrayMethod
-(NSInteger)sortDataArrayByInsertElement :(BillListLibrary *)listLib{
    BOOL flag = NO;
    NSInteger i;
    NSDateFormatter  *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY年MM月dd日"];
    NSDate *newDate = [dateFormat dateFromString:listLib.date];
    
    for(i = 0;i<self.dataArray.count;i++){
        BillListLibrary *lib = [self.dataArray objectAtIndex:i];
        NSDate *date = [dateFormat dateFromString:lib.date];
        if([date earlierDate:newDate] == newDate){
            [self.dataArray insertObject:listLib atIndex:i];
            flag = YES;
            break;
        }
    }
    if(flag == NO){
        [self.dataArray addObject:listLib];
        return self.dataArray.count;
    }else{
        return i;
    }
}




//设置界面跳转
-(void)settings{
    
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
    
}



#pragma-mark tableView Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
//    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BillListLibrary *lib = [self.dataArray objectAtIndex:section];
//    UILabel *headerLabel = [[UILabel alloc] init];
//    [headerLabel setText:lib.date];
//    tableView.tableHeaderView = headerLabel;
    return lib.billArray.count;
    
//    return 5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return [NSString stringWithFormat:@"%ld",section];
    BillListLibrary *lib = [self.dataArray objectAtIndex:section];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSDate *date = [formatter dateFromString:lib.date];
    //取出来的时间
    NSDateComponents *libDC = dateComponent(date);
    //当前时间
    NSDateComponents *currentDC = dateComponent([NSDate dateWithTimeIntervalSinceNow:0]);
    //如果是时间是当前的年份时间就省略年份
    if(libDC.year == currentDC.year){
        [formatter setDateFormat:@"MM月dd日"];
        return [formatter stringFromDate:date];
    }else{
        return lib.date;
    }
    
    
    
    
    
    
    return lib.date;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillListLibrary *lib = [self.dataArray objectAtIndex:indexPath.section];
    BillList *list = [lib.billArray objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"ListID";
    BillListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        
        cell = [BillListTableViewCell billListTableViewCellWithTableView:self.listTableView identifier:identifier];
    }
    //加载数据
//    [cell.textLabel setText:list.date];
    [cell.date setText:list.date];
    if(list.remark == 0){
        [cell.remark setText:@"进货"];
        [cell.outOrIn setText:@"支出"];
    }else{
        [cell.remark setText:@"售出"];
        [cell.outOrIn setText:@"收入"];
    }
    [cell.price setText:[NSString stringWithFormat:@"%.2lf",list.totle]];
    tableView.rowHeight = 80;
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BillListLibrary *lib = [self.dataArray objectAtIndex:indexPath.section];
    BillList *list = [lib.billArray objectAtIndex:indexPath.row];
    AddViewController *addVC = [AddViewController editViewWithDate:list.date billListRemark:list.remark productArray:list.products];
    addVC.delegate = self;

    
    
    [lib.billArray removeObjectAtIndex:indexPath.row];
    if(lib.billArray.count == 0){
        [self.dataArray removeObjectAtIndex:indexPath.section];
        [self.listTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationMiddle];
    }else{
        [self.listTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    
    [self.navigationController pushViewController:addVC animated:YES];
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        BillListLibrary *lib = [self.dataArray objectAtIndex:indexPath.section];
        //删除数据
        [lib.billArray removeObjectAtIndex:indexPath.row];
        
        //若删除后无数据则删除section
        if(lib.billArray.count == 0){
            //移除section的title
            [self.dataArray removeObjectAtIndex:indexPath.section];
            //局部刷新数据
            [self.listTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationMiddle];
        }else{
            //局部刷新数据
            [self.listTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationMiddle];
        }
        
        //写入文件
        [NSKeyedArchiver archiveRootObject:self.dataArray toFile:ArchiveFilePath(@"BillListData")];
        
        
        
    }];
    return @[action];
}



#pragma-mark viewJump Methods
-(void)addLogDataClick{
    AddViewController *addVC = [[AddViewController alloc] init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma-mark AddViewControllerDelegate Methods
-(void)addViewController:(AddViewController *)addViewController sendBillList:(BillList *)billList{
    NSString *date = billList.date;
    
//    __block BOOL isFindOut;
    if(self.dataArray.count > 0){
        //查找是否为空
        for(int i = 0;i<self.dataArray.count;i++){
            BillListLibrary *lib = [self.dataArray objectAtIndex:i];
            if([date isEqualToString:lib.date]){
                [lib.billArray addObject:billList];
                break;
            }
            if(i == self.dataArray.count - 1 && (![date isEqualToString:lib.date])){
                //没找到
                BillListLibrary *bl = [[BillListLibrary alloc] init];
                bl.date = date;
                if(bl.billArray == nil){
                    bl.billArray = [[NSMutableArray alloc] init];
                }
                [bl.billArray addObject:billList];
//                [self.dataArray addObject:bl];
                //添加到array
                [self sortDataArrayByInsertElement:bl];
                break;
                
            }
        }
        
    }else{
        BillListLibrary *lib = [[BillListLibrary alloc] init];
        lib.date = date;
        if(lib.billArray == nil){
            lib.billArray = [NSMutableArray array];
        }
        [lib.billArray addObject:billList];
        [self.dataArray addObject:lib];
        NSLog(@"%@",lib.billArray);
    }
    
//    [self.listTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.listTableView reloadData];

    
//    [self.dataArray addObject:billList];
    
    
    //写入文件
    [NSKeyedArchiver archiveRootObject:self.dataArray toFile:ArchiveFilePath(@"BillListData")];

    
}



@end
