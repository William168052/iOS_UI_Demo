//
//  ViewController.m
//  购物车Demo
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"

#define OrangeW self.OrangeView.frame.size.width
#define OrangeH self.OrangeView.frame.size.height
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *OrangeView;
@property (nonatomic,assign) NSInteger productNum;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (nonatomic ,strong) NSArray *products;
@end

@implementation ViewController

//懒加载数据
-(NSArray *)products{
    //判断是否有值
    if(_products == nil){
        //初始化
        NSArray *arr = @[
                       @{@"title" : @"链条包", @"icon" : @"liantiaobao"},
                       @{@"title" : @"手提包", @"icon" : @"shoutibao"},
                       @{@"title" : @"单肩包", @"icon" : @"danjianbao"},
                       @{@"title" : @"双肩包", @"icon" : @"shuangjianbao"},
                       @{@"title" : @"钱包", @"icon" : @"qianbao"},
                       @{@"title" : @"斜跨包", @"icon" : @"xiekuabao"},
                       ];
        
        _products = [Product productsWithDictionaryArray:arr];
    }
    return _products;
    
}

//添加商品
- (IBAction)addProduct:(UIButton *)sender {
    
    
    //定义间距
    CGFloat xSpace = 10;
    CGFloat ySpace = 30;
    
    //定义商品view宽高
    CGFloat width = (OrangeW - 2 * xSpace) / 3;
    CGFloat height = (OrangeH - ySpace) / 2;
    
    //定义商品view位置
    CGFloat xPosition = (self.OrangeView.subviews.count % 3) * (width + xSpace);
    CGFloat yPosition = (self.OrangeView.subviews.count / 3) * (height + ySpace);
    
    //创建UIView
    UIView *productV = [[UIView alloc] initWithFrame:CGRectMake(xPosition, yPosition, width, height)];
    
    //设置背景颜色
//    productV.backgroundColor = [UIColor redColor];
    
    /*******************************设置图片和标题*******************************/
    //添加商品图片的View
    UIImageView *icon = [[UIImageView alloc] init];
    icon.frame = CGRectMake(0, 0, width, height * 3 / 4);
    //    icon.backgroundColor = [UIColor blueColor];
    Product *product = self.products[self.productNum];
    //设置图片
    //    NSString *iconName = dict[@"icon"];
    //    icon.image = [UIImage imageNamed:iconName];
    icon.image = [UIImage imageNamed:product.icon];
    [productV addSubview:icon];
    
    
    //添加商品名称的Label
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, height * 3 /4, width, height / 4);
    //    title.backgroundColor = [UIColor yellowColor];
    [productV addSubview:title];
    //设置商品名称
    NSString *titleName = product.title;
    title.text = titleName;
    //设置文字居中
    [title setTextAlignment:NSTextAlignmentCenter];
    /*************************************************************************/
    
    
    //添加view
    [self.OrangeView addSubview:productV];
    
    //记录商品的数目
    self.productNum++;
    
    //让removeBtn可点击
    self.removeBtn.enabled = YES;
    
    //判断按钮状态
    if(self.productNum == 6){
        sender.enabled = NO;
    }
}


//删除商品
- (IBAction)removeProduct:(UIButton *)sender {
    //删除商品
    [self.OrangeView.subviews.lastObject removeFromSuperview];
    
    //记录商品数目
    self.productNum--;
    
    //判断按钮状态
    if(self.productNum == 0){
        sender.enabled = NO;
    }
    
    //让addBtn可点击
    self.addBtn.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.products = @[
//                      @{@"title" : @"链条包", @"icon" : @"liantiaobao"},
//                      @{@"title" : @"手提包", @"icon" : @"shoutibao"},
//                      @{@"title" : @"单肩包", @"icon" : @"danjianbao"},
//                      @{@"title" : @"双肩包", @"icon" : @"shuangjianbao"},
//                      @{@"title" : @"钱包", @"icon" : @"qianbao"},
//                      @{@"title" : @"斜跨包", @"icon" : @"xiekuabao"},
//                      ];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
