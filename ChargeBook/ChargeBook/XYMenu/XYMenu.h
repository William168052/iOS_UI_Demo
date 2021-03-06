//
//  XYMenu.h
//  XYMenu
//
//  Created by FireHsia on 2018/1/26.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYMenuBackView;
@class XYMenuView;

typedef enum : NSUInteger {
    XYMenuLeftNavBar,
    XYMenuRightNavBar,
    XYMenuLeftNormal,
    XYMenuMidNormal,
    XYMenuRightNormal,
} XYMenuType;

typedef void(^ItemClickIndexBlock)(NSInteger index);

@interface XYMenu : UIView

+ (void)showMenuWithTitles:(NSArray *)titles inView:(UIView *)view menuType:(XYMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block;

/**
 展示菜单到当前的navigationVC

 @param titles 标题
 @param menuType 菜单类型
 @param currentNavVC 展示当前的navigationVC
 @param block 回调block
 */
//+ (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(XYMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block;
+ (void)showMenuWithTitles:(NSArray *)titles menuType:(XYMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block;


/**
 隐藏菜单
 @param view 当前的View
 */
+ (void)dismissMenuInView:(UIView *)view;


@end
