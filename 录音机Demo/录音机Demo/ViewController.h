//
//  ViewController.h
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordFile;
@interface ViewController : UIViewController

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
-(void)setDataArrayWithData :(RecordFile *)data;

@end

