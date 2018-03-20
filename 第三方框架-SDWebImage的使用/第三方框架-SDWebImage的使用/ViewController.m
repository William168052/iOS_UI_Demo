//
//  ViewController.m
//  第三方框架-SDWebImage的使用
//
//  Created by William on 2018/3/19.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self download];
}


-(void)download{
//    http://d.hiphotos.baidu.com/image/pic/item/d833c895d143ad4b3ae286d88e025aafa50f06de.jpg
    
    NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/d833c895d143ad4b3ae286d88e025aafa50f06de.jpg"];
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"SD_placeHolder"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"直接下载");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"从磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"从内存缓存");
                break;
                
            default:
                break;
        }
    }];
}
@end
