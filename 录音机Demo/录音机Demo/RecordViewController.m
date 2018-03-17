//
//  RecordViewController.m
//  录音机Demo
//
//  Created by William on 2018/2/4.
//  Copyright © 2018年 William. All rights reserved.
//

#import "RecordViewController.h"
#import "ViewController.h"
#import "Recorder.h"
#import "RecordFile.h"
//保存路径
#define storeURL [NSHomeDirectory() stringByAppendingString:@"/Documents/"]
//文件名
#define fileName [NSString stringWithFormat: @"新录音%ld.mp3",++defaultRecNum]
//当前文件名
#define currentFileName [NSString stringWithFormat: @"新录音%ld.mp3",defaultRecNum]
//文件路径（中文转码）
#define fileURL(fileName) [storeURL stringByAppendingString:[fileName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]


@interface RecordViewController ()

//计时器
@property(nonatomic,assign)NSInteger m_second;
@property(nonatomic,assign)NSInteger second;
@property(nonatomic,assign)NSInteger minute;
@property(nonatomic,assign)NSInteger hour;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)NSTimer *timer;

//录音
@property(nonatomic,assign)BOOL isPause;
@property(nonatomic,strong)UIButton *centerBtn;
@property(nonatomic,strong)Recorder *rec;
@property(nonatomic,strong)RecordFile *file;



//文件管理
@property(nonatomic,strong)NSFileManager *fileManager;





@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",storeURL);
    self.navigationController.navigationBar.hidden = YES;
    
    [self setBackground];
    [self setUIElement];
    
    //启动计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startTiming) userInfo:nil repeats:YES];
    //开始录制
    self.rec = [[Recorder alloc] init];
    //设置文件名并转码
    
    [self.rec startRecording :[NSURL URLWithString:fileURL(fileName)]];
    self.isPause = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma-mark 懒加载方法
-(NSFileManager *)fileManager{
    if(_fileManager == nil){
        _fileManager = [[NSFileManager alloc] init];
    }
    return _fileManager;
}


#pragma-mark 设置背景以及界面元素
- (void)setBackground{
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//
//    backgroundImage.image = [UIImage imageNamed:@"background.jpg"];
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


- (void)setUIElement{
    //添加底部的View
    UIView *buttomV = [[UIView alloc] initWithFrame:CGRectMake( 0, ScreenH * 3 / 4, ScreenW, ScreenH / 4)];
    //    buttomV.backgroundColor = [UIColor redColor];
    //添加按钮
    //中部
    UIButton *centerBtn = [[UIButton alloc] initWithFrame:CGRectMake((buttomV.frame.size.width - 80) / 2, (buttomV.frame.size.height - 80) / 2, 80, 80)];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"record_end_button_Default.png"] forState:UIControlStateNormal];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"record_end_button_HighLighted.png"] forState:UIControlStateHighlighted];
    [centerBtn addTarget:self action:@selector(recordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.centerBtn = centerBtn;
    [buttomV addSubview:self.centerBtn];
    
    
    //左部
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, (buttomV.frame.size.height - 60) / 2, 60, 60)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"cancel_button_Default.png"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"cancel_button_HighLighted.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [buttomV addSubview:leftBtn];
    
    //右部
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, (buttomV.frame.size.height - 60) / 2, 60, 60)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ready_button_Default.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ready_button_HighLighted.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [buttomV addSubview:rightBtn];
    [self.view addSubview:buttomV];
   
    
    //添加TimeLabel
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (ScreenH - 30 - ScreenH / 4), ScreenW, 30)];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeLabel setFont:[UIFont systemFontOfSize:40]];
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",self.hour,self.minute,self.second];
    [self.view addSubview:self.timeLabel];
}

#pragma-mark 计时器方法
- (void)startTiming{
    self.m_second++;
    if(self.m_second == 100){
        self.second++;
        self.m_second = 0;
    }
    if(self.second == 60){
        self.minute++;
        self.second = 0;
    }
    if(self.minute == 60){
        self.hour++;
        self.minute = 0;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",self.hour,self.minute,self.second];
}
//暂停计时
- (void)pauseTiming{
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma-mark 按钮点击方法
- (void)recordButtonClicked{
    //正在录制
    if(self.isPause == NO){
        //更换背景图标
        [UIView animateWithDuration:0.5 animations:^{
            self.centerBtn.alpha = 0;
            [self.centerBtn setBackgroundImage:[UIImage imageNamed:@"record_button_Default"] forState:UIControlStateNormal];
            [self.centerBtn setBackgroundImage:[UIImage imageNamed:@"record_button_HighLighted"] forState:UIControlStateHighlighted];
            self.centerBtn.alpha = 1;
        }];
        //暂停
        [self pauseTiming];
        [self.rec pauseRecording];
        self.isPause = YES;
    }else{
        //更换背景图标
        [UIView animateWithDuration:0.5 animations:^{
            self.centerBtn.alpha = 0;
            [self.centerBtn setBackgroundImage:[UIImage imageNamed:@"record_end_button_Default"] forState:UIControlStateNormal];
            [self.centerBtn setBackgroundImage:[UIImage imageNamed:@"record_end_button_HighLighted"] forState:UIControlStateHighlighted];
            self.centerBtn.alpha = 1;
        }];
        //继续
        [self.timer setFireDate:[NSDate dateWithTimeInterval:0.01 sinceDate:[NSDate date]]];
        self.isPause = NO;
        [self.rec startRecordAfterPause];
    }
}

//左边button
- (void)leftButtonClicked{
    //删除之前保存的文件
    NSError *removeFileError;
    NSLog(@"%@",fileURL(currentFileName));
    [self.fileManager removeItemAtPath:fileURL(currentFileName) error:&removeFileError];
    if(removeFileError!=nil){
        NSLog(@"%@",removeFileError);
    }
    
    //把计数器减1
    defaultRecNum--;
    [self.navigationController popViewControllerAnimated:YES];
}



//右边button
- (void)rightButtonClicked{
    [self.rec stopRecording];
    //暂停计时器
    [self pauseTiming];
    //弹框
    UIAlertController *recAlert = [UIAlertController alertControllerWithTitle:@"保存为" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [recAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"文件名.mp3";
    }];
    //确定按钮
    UIAlertAction *okAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取文本框文本
        UITextField *file_name = recAlert.textFields.lastObject;
        //文件重命名
        NSError *renameFileError;
        
        //截取字符串（判断是否有后缀）
        
        if(file_name.text.length == 0){
            //输入框为空
            file_name.text = currentFileName;
        }else if(file_name.text.length <= 4 && file_name.text.length > 0){
            //输入框有值但是长度小于等于4（没有后缀）
            file_name.text = [file_name.text stringByAppendingString:@".mp3"];
            
        }else if(![[file_name.text substringFromIndex:(file_name.text.length - 4)] isEqualToString:@".mp3"]){
            //没有后缀
            file_name.text = [file_name.text stringByAppendingString:@".mp3"];
            
        }
        
        [self.fileManager moveItemAtPath:fileURL(currentFileName) toPath:fileURL(file_name.text) error:&renameFileError];
        if(renameFileError!=nil){
            NSLog(@"%@",renameFileError);
        }
        
        //把计数器减1
        if(![file_name.text isEqualToString:currentFileName]){
            defaultRecNum--;
        }
        
        //设置file
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY年MM月dd日"];
        NSDate *currentDate = [NSDate date];
        NSString *dateStr = [formatter stringFromDate:currentDate];
        
        self.file = [[RecordFile alloc] initWithMainName:file_name.text andCreateTime:dateStr andAudioLength:self.timeLabel.text andFileURL:fileURL(file_name.text)];
        
        //通过代理传值
        if(self.file){
            [self.delegate sendRecordFile:self.file];
        }
        
        //返回上一级界面
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //取消按钮
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //删除之前保存的文件
        NSError *removeFileError;
        NSLog(@"%@",fileURL(currentFileName));
        [self.fileManager removeItemAtPath:fileURL(currentFileName) error:&removeFileError];
        if(removeFileError!=nil){
            NSLog(@"%@",removeFileError);
        }
        
        //把计数器减1
        defaultRecNum--;
        
        //返回上一级界面
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [recAlert addAction:okAct];
    [recAlert addAction:cancelAct];
    [self presentViewController:recAlert animated:YES completion:nil];
    
    
}






@end
