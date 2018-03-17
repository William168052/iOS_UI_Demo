//
//  main.m
//  #pragmamark基本使用
//
//  Created by William on 2017/4/2.
//  Copyright © 2017年 William. All rights reserved.
//

/*
 事物名称：士兵(Sodier)
 属性：姓名(name)，身高(height)，体重(weight)
 行为：打枪(fire)，打电话(callphone)
 
 事物名称：枪(Gun)
 属性：弹夹(clip)，型号(model)
 行为：上弹夹(addClip)
 
 事物名称：弹夹(Clip)
 属性：子弹(Bullet)
 行为：上子弹(addBullet)
 */


//pragma mark 可以将程序里面的板块进行分类，查找起来更方便


#import <Foundation/Foundation.h>

//创建枪类
//#pragma mark 枪
//#pragma mark -
#pragma mark - 枪
@interface Gun : NSObject
{
@public
    int _bullet;
}
//射击
-(void)shoot;

@end

@implementation Gun;

-(void)shoot
{
    //判断子弹数
    _bullet--;
    if(_bullet>0)
    {
        NSLog(@"打了一枪,剩余%d颗子弹",_bullet);
    }
    else{
        NSLog(@"没有子弹了，请换弹夹");
    }
}

@end

//创建士兵类
//#pragma mark 士兵
//#pragma mark -
#pragma mark - 士兵
@interface Sodier : NSObject
{
@public
    NSString * _name;
    double _height;
    double _weight;
}

-(void)fire:(Gun *)gun;

@end

@implementation Sodier

-(void)fire:(Gun *)gun
{
    [gun shoot];
}

@end

//#pragma mark 程序入口
//#pragma mark -
#pragma mark - 程序入口
int main()
{
    //创建士兵
    Sodier *sp=[Sodier new];
    sp->_name=@"小明";
    sp->_height=1.88;
    sp->_weight=100;
    //创建一把枪
    Gun *gun=[Gun new];
    gun->_bullet=100;
    //让士兵开枪
    [sp fire:gun];
    return 0;
}
