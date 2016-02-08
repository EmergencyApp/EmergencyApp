//
//  BasicCardViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/8.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BasicCardViewController.h"
#import <STPopup/STPopup.h>

@interface BasicCardViewController ()

@end

@implementation BasicCardViewController

#pragma mark - Card UI

- (void)navigationBarSetup {
    [self.popupController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.popupController.navigationBar.barStyle = UIBarStyleBlack;
    self.popupController.navigationBar.translucent = NO;
    [self.popupController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, screenSize.height/5*3);
        self.landscapeContentSizeInPopup = CGSizeMake(screenSize.height/5*4, screenSize.width/5*3);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self navigationBarSetup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[self.popupController.navigationBar.barTintColor colorWithAlphaComponent:1]];
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
