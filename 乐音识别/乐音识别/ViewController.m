//
//  ViewController.m
//  乐音识别
//
//  Created by William on 2018/1/28.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "Recorder.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beginRec;
@property (weak, nonatomic) IBOutlet UIButton *endingRec;
@property (weak, nonatomic) IBOutlet UIProgressView *timeLine;
@property (nonatomic ,strong) Recorder *recorder;

@end

@implementation ViewController
//懒加载recorder
-(Recorder *)recorder{
    if(_recorder == nil){
        _recorder = [[Recorder alloc] init];
    }
    return _recorder;
}


//开始录制
- (IBAction)beginRec:(id)sender {
    self.endingRec.enabled = YES;
    [self.recorder startRecording];
}
- (IBAction)endingRec:(id)sender {
    self.endingRec.enabled = NO;
    [self.recorder stopRecording];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
