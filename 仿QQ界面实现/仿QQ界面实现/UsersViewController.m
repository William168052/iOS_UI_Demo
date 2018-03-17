//
//  UsersViewController.m
//  仿QQ界面实现
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
    [self loadUsersView];
    
    //在leftV添加tableView
    LeftViewController *lVC = [[LeftViewController alloc] init];
    lVC.view.frame = self.leftV.bounds;
    lVC.view.backgroundColor = [UIColor redColor];
    [self.leftV addSubview:lVC.view];
    [self addChildViewController:lVC];
    
    //在mainV添加tableView
    MainViewController *mVC = [[MainViewController alloc] init];
    mVC.view.frame = self.mainV.bounds;
    mVC.view.backgroundColor = [UIColor blueColor];
    [self.mainV addSubview:mVC.view];
    //添加父控制器属性
    mVC.usersVC = self;
    [self addChildViewController:mVC];
}

- (void)loadUsersView{
    //左边的view
    UIView *leftV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    leftV.backgroundColor = [UIColor redColor];
    self.leftV = leftV;
    [self.view addSubview:leftV];
    //mainV
    UIView *mainV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainV.backgroundColor = [UIColor blueColor];
    self.mainV = mainV;
    [self.view addSubview:mainV];
    
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
