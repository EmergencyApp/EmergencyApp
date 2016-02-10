//
//  JVFloatLabeledTextField+InterfaceCustom.m
//  Emergency
//
//  Created by 孙恺 on 16/2/10.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "JVFloatLabeledTextField+InterfaceCustom.h"
#import <Colours/Colours.h>

@implementation JVFloatLabeledTextField (InterfaceCustom)

+ (void)setupTextField:(JVFloatLabeledTextField *)textField {
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setTintColor:[UIColor whiteColor]];
    [textField setTextColor:[UIColor whiteColor]];
    [textField setFloatingLabelTextColor:[UIColor whiteColor]];
    [textField setValue:[UIColor black75PercentColor] forKeyPath:@"_placeholderLabel.textColor"];
}

@end
