//
//  WarningViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/7.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "WarningViewController.h"

@interface WarningViewController ()

@end

@implementation WarningViewController {
    CGFloat _brightness;
}

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
                [[UIScreen mainScreen] setBrightness:1.0f];
            }];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIScreen mainScreen] setBrightness:_brightness];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[UIScreen mainScreen] setBrightness:_brightness];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

