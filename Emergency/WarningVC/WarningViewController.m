//
//  WarningViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/7.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "WarningViewController.h"
#import <ZLSwipeableView/ZLSwipeableView.h>
#import <ZLSwipeableView/ViewManager.h>
#import <ZLSwipeableView/Utils.h>
#import "BasicCardView.h"

@interface WarningViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (nonatomic, strong) ZLSwipeableView *cardsStackView;

@end

@implementation WarningViewController {
    CGFloat _brightness;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bt_mymusic_time_bg_afternoon.jpg"];
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    
    self.cardsStackView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
    self.cardsStackView.dataSource = self;
    self.cardsStackView.delegate = self;
    [self.cardsStackView setNumberOfActiveViews:1];
    [self.view addSubview:self.cardsStackView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _brightness = [UIScreen mainScreen].brightness;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setAlpha:0];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.view setAlpha:1];
                // TODO: birghtness.
//                [[UIScreen mainScreen] setBrightness:1.0f];
            }];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIScreen mainScreen] setBrightness:_brightness];
}

- (void)viewDidLayoutSubviews {
    [self.cardsStackView loadViewsIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    BasicCardView *baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, self.view.frame.size.height/5*4)];
    [baseinfocard setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    return baseinfocard;
}

#pragma mark - Dismiss

- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[UIScreen mainScreen] setBrightness:_brightness];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

