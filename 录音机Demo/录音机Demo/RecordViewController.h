//
//  RecordViewController.h
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordFile;
//传值代理
@protocol RecordViewControllerDelegate <NSObject>

- (void)sendRecordFile :(RecordFile *)file;

@end

@interface RecordViewController : UIViewController

//代理
@property(nonatomic,strong)id<RecordViewControllerDelegate> delegate;

@end
