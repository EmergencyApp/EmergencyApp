//
//  PanView.m
//  Emergency
//
//  Created by 孙恺 on 16/2/9.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "PanView.h"

@implementation PanView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 创建一个贝塞尔曲线句柄
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path moveToPoint:CGPointMake(0, self.frame.size.height-15)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-15) controlPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    [path addLineToPoint:CGPointMake(0, 0)];
    
    // 创建描边（Quartz）上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将此path添加到Quartz上下文中
    CGContextAddPath(context, path.CGPath);
    // 设置本身颜色
    [[UIColor redColor] set];
    // 设置填充的路径
    CGContextFillPath(context);
}

@end
