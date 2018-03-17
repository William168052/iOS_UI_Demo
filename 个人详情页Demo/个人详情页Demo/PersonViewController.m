//
//  PersonViewController.m
//  个人详情页Demo
//
//  Created by William on 2018/3/11.
//  Copyright © 2018年 William. All rights reserved.
//

#import "PersonViewController.h"
#define OriOffsetY (NSInteger)self.view.frame.size.height / 3
//#define OriginH self.view.frame.size.height / 3
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation PersonViewController



- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView.contentInset = UIEdgeInsetsMake(OriOffsetY, 0, 0, 0);
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //取消自动让出NavigationBar
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
//    self.navigationController.navigationBar.translucent = NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offset = scrollView.contentOffset.y + OriOffsetY;
    self.topViewHeightConstraint.constant = - offset;
    NSInteger off = (NSInteger)scrollView.contentOffset.y;
    
    if(off >= - OriOffsetY / 2){
        
        //显示navigationBar
        UIImage *bgImg = [UIImage imageNamed:@"white_bg"];
        [self.navigationController.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
        
        
        
    }else{
        //设置导航栏透明
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }

    NSLog(@"%ld -------- %ld -------- %lf",off,OriOffsetY / 2,self.topViewHeightConstraint.constant);


    
    
}

//-(void)viewDidLayoutSubviews{
//    self.topViewHeightConstraint.constant = 0;
//}




#pragma-mark UITableViewDelegate Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

@end
