//
//  ViewController.m
//  transform
//
//  Created by William on 2018/3/12.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)up:(UIButton *)sender {
    
    //向上平移
    
    [UIView animateWithDuration:0.5 animations:^{
        //使用make是从最原始的位置平移
        //self.imageV.transform = CGAffineTransformMakeTranslation(0, -100);
        //相对于上一次位置平移
        self.imageV.transform = CGAffineTransformTranslate(self.imageV.transform, 0, -100);
    }];
    
    
}
- (IBAction)down:(UIButton *)sender {
    
    //向下平移
    [UIView animateWithDuration:0.5 animations:^{
        //使用make是从最原始的位置平移
        //self.imageV.transform = CGAffineTransformMakeTranslation(0, 100);
        //相对于上一次位置平移
        self.imageV.transform = CGAffineTransformTranslate(self.imageV.transform, 0, 100);
    }];
}
- (IBAction)rotation:(UIButton *)sender {
    
    //旋转(度数是一个弧度)
    [UIView animateWithDuration:0.5 animations:^{
        //        self.imageV.transform = CGAffineTransformMakeRotation(M_PI / 4);
        self.imageV.transform = CGAffineTransformRotate(self.imageV.transform, M_PI_4);
    }];
    
}
- (IBAction)scaleBig:(UIButton *)sender {
//    self.imageV.transform = CGAffineTransformMakeScale(1.2, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.imageV.transform = CGAffineTransformScale(self.imageV.transform, 1.2, 1.2);
    }];
}
- (IBAction)scaleSmall:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageV.transform = CGAffineTransformScale(self.imageV.transform, 0.8, 0.8);
    }];
}



@end
