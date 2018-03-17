//
//  UsersViewController.m
//  模仿QQ界面实现抽屉效果
//
//  Created by William on 06/01/2018.
//  Copyright © 2018 William. All rights reserved.
//

#import "UsersViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"

@interface UsersViewController ()

@property (nonatomic,strong)UIView *leftV;
@property (nonatomic,strong)UIView *mainV;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    //添加侧边的View
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    _leftV = leftVC.tableView;
    [self.view addSubview:_leftV];
    //>>将侧边控制器添加为子控制器
    [self addChildViewController:leftVC];
    
    //添加主界面的View
    MainViewController *mainVC = [[MainViewController alloc] init];
    _mainV = mainVC.tableView;
    [self.view addSubview:_mainV];
    [self addChildViewController:mainVC];

    
    //添加拖拽手势
    UIPanGestureRecognizer *panM = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMainV:)];
    [self.mainV addGestureRecognizer:panM];

}


- (void)panMainV :(UIPanGestureRecognizer *)recognizer{

    CGPoint transP = [recognizer translationInView:self.mainV];

    
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    //当手指离开时
    if(recognizer.state == UIGestureRecognizerStateEnded){
        CGRect frame = self.mainV.frame;
        if(frame.origin.x < ScreeW / 2){
            //吸附到左边
            frame.origin.x = 0;
        }else{
            //吸附到右边
            frame.origin.x = LeftViewW;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.mainV.frame = frame;
        }];

        
    }

    [recognizer setTranslation:CGPointZero inView:self.mainV];
}

//根据偏移量求mainV的Frame
- (CGRect)frameWithOffsetX :(CGFloat)x{
    CGRect frame =self.mainV.frame;
    if(self.mainV.frame.origin.x <= 0 && x <= 0){
        //设置向左的边界
        frame.origin.x = 0;
    }else if(self.mainV.frame.origin.x >= LeftViewW && x >= 0){
        //设置向右的边界
        frame.origin.x = ScreeW / 5 * 4;
    }else{
        frame.origin.x += x;
    }
    return frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
