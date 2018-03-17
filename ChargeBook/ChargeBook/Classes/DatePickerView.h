//
//  DatePickerView.h
//  ChargeBook
//
//  Created by William on 2018/2/26.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *certain;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
