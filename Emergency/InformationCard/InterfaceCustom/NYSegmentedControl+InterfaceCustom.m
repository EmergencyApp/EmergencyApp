//
//  NYSegmentedControl+InterfaceCustom.m
//  Emergency
//
//  Created by 孙恺 on 16/2/10.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "NYSegmentedControl+InterfaceCustom.h"

@implementation NYSegmentedControl (InterfaceCustom)

+ (void)setupSegmentControl:(NYSegmentedControl *)segmentControl {
    segmentControl.backgroundColor = [UIColor clearColor];
    segmentControl.borderColor = [UIColor clearColor];
    segmentControl.segmentIndicatorBorderColor = [UIColor clearColor];
    segmentControl.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    segmentControl.segmentIndicatorInset = 0.0f;
    segmentControl.titleTextColor = [UIColor lightGrayColor];
    segmentControl.selectedTitleTextColor = [UIColor darkGrayColor];
    [segmentControl sizeToFit];
}

@end
