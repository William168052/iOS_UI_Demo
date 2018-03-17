//
//  main.m
//  demo
//
//  Created by William on 2017/11/30.
//  Copyright © 2017年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlackPrinter.h"
#import "ColorPrinter.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int flag;
        scanf( "%d",&flag);
        if(flag == 1){
            Printer *p1 = [BlackPrinter new];
            [p1 print];
        }else{
            Printer *p2 = [ColorPrinter new];
            [p2 print];
        }
    }
    return 0;
}
