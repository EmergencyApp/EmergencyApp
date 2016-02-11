//
//  BasicCardView.m
//  Emergency
//
//  Created by 孙恺 on 16/2/11.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BasicCardView.h"

@implementation BasicCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        [self.tableView setUserInteractionEnabled:NO];
        [self addSubview:self.tableView];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.tableView.layer setCornerRadius:10.0f];
    [self.tableView setClipsToBounds:YES];
    
    [self.layer setCornerRadius:10.0f];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.6f];
    [self.layer setShadowRadius:10.0f];
    self.layer.masksToBounds = NO;
    [self setClipsToBounds:NO];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.layer.shadowPath = path.CGPath;
}

@end
