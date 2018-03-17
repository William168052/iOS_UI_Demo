//
//  ViewController.m
//  AudioQueueService实现音频录制
//
//  Created by William on 2018/1/29.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "Recorder.h"
@interface ViewController ()
@property (nonatomic,strong) Recorder *rec;
@end

@implementation ViewController
- (IBAction)beginRecording:(UIButton *)sender {
    [self.rec startRecording:[NSURL URLWithString:@"/Users/william/Desktop/123.mp3"]];
}

- (IBAction)stopRecording:(UIButton *)sender {
    [self.rec stopRecording];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rec = [[Recorder alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
