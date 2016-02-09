//
//  AppDelegate.m
//  Emergency
//
//  Created by 孙恺 on 16/2/6.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "WKSectionView.h"
#import <Colours/Colours.h>

@implementation WKSectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}

-(void)setUI
{
//    NSArray *normalImages = @[@"icon_home_localMusic_normal.png",@"icon_home_collection_normal.png",@"icon_home_myPlaylist_normal.png",@"icon_home_musicLibrary_normal.png"];
//    NSArray *presslImages = @[@"icon_home_localMusic_press.png",@"icon_home_collection_press.png",@"icon_home_myPlaylist_press.png",@"icon_home_musicLibrary_press.png"];
    
    NSArray *normalImages = @[@"icon_home_localMusic_normal.png", @"icon_home_localMusic_normal.png", @"icon_home_localMusic_normal.png"];
    NSArray *presslImages = @[@"icon_home_localMusic_normal.png", @"icon_home_localMusic_normal.png", @"icon_home_localMusic_normal.png"];
    
    NSArray *title = @[@"应用设置",@"常用药管理",@"紧急联系人"];
    
    CGFloat width = self.frame.size.width/3.0;
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        [button setFrame:CGRectMake((width-40)/2.0+width*i, 30, 40, 40)];
        [button setImage:[UIImage imageNamed:presslImages[i]] forState:UIControlStateHighlighted];
        [self addSubview:button];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width-80)/2.0+width*i, 80, 80, 25)];
        titleLabel.text = title[i];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 创建一个贝塞尔曲线句柄
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
//
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, 0) controlPoint:CGPointMake(self.frame.size.width/2,15)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];

    // 创建描边（Quartz）上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将此path添加到Quartz上下文中
    CGContextAddPath(context, path.CGPath);
    // 设置本身颜色
    [[UIColor colorWithRed:255.0f/255.0f green:213.0f/255.0f blue:.0f/255.0f alpha:1] set];
    // 设置填充的路径
    CGContextFillPath(context);
    
}

@end
