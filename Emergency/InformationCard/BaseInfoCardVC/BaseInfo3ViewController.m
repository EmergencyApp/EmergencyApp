//
//  BaseInfo3ViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/10.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfo3ViewController.h"
#import <STPopup/STPopup.h>

@interface BaseInfo3ViewController ()

@end

@implementation BaseInfo3ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 258);
        self.landscapeContentSizeInPopup = CGSizeMake(screenSize.height/5*4, screenSize.width/5*3);
    }
    return self;
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
