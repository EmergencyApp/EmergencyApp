//
//  BaseInfoViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/8.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "BaseInfo2ViewController.h"
#import <STPopup/STPopup.h>

@interface BaseInfoViewController ()

@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    [self.navigationItem setRightBarButtonItem:button];
    // Do any additional setup after loading the view from its nib.
}

- (void)push {
    BaseInfo2ViewController *nextStep = [[BaseInfo2ViewController alloc] init];
//    [self presentViewController:nextStep animated:YES completion:nil];
    [self.popupController pushViewController:nextStep animated:YES];
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
