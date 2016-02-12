//
//  BaseInfo4ViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/10.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfo4ViewController.h"
#import <STPopup/STPopup.h>
#import <NYSegmentedControl/NYSegmentedControl.h>
#import <Colours/Colours.h>

#import "HMFileManager.h"

#import "InterfaceCustom.h"

@interface BaseInfo4ViewController ()
@property (weak, nonatomic) IBOutlet NYSegmentedControl *eatingSC;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *washingSC;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *wearingSC;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *toiletSC;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *activitySC;

@property (weak, nonatomic) IBOutlet UILabel *eatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *washingLabel;
@property (weak, nonatomic) IBOutlet UILabel *wearLabel;
@property (weak, nonatomic) IBOutlet UILabel *toiletLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@end

@implementation BaseInfo4ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupForms];
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
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 324);
        self.landscapeContentSizeInPopup = CGSizeMake(screenSize.height/5*4, screenSize.width/5*3);
    }
    return self;
}

#pragma mark - Setup forms UI

- (void)setupNavigationItem {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    [self.navigationItem setRightBarButtonItem:button];
}

- (void)setupForms {
//    NSArray *labelArray = @[self.eatingLabel, self.washingLabel, self.wearLabel, self.toiletLabel, self.activityLabel];
//    
//    for (UILabel *label in labelArray) {
//        [label setTextColor:[UIColor black75PercentColor]];
//    }
    
    NSArray *scArray = @[self.eatingSC, self.washingSC, self.wearingSC, self.toiletSC, self.activitySC];
    
    for (NYSegmentedControl *segmentedControl in scArray) {
        [segmentedControl insertSegmentWithTitle:@"不能自理" atIndex:0];
        [segmentedControl insertSegmentWithTitle:@"重依赖" atIndex:0];
        [segmentedControl insertSegmentWithTitle:@"轻依赖" atIndex:0];
        [segmentedControl insertSegmentWithTitle:@"独立" atIndex:0];
        [segmentedControl reloadData];
        [NYSegmentedControl setupSegmentControl:segmentedControl];
    }
    
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    return YES;
}

#pragma mark - Next

- (void)push {
    NSArray *array = @[@[self.name,
                         self.birthday,
                         self.age,
                         self.sex,
                         self.bloodType],
                       @[self.height,
                         self.weight,
                         self.waist,
                         self.bmi],
                       @[self.nationality,
                         self.religion,
                         self.telPersonal,
                         self.addr,
                         self.phoneHome],
                       @[[self.eatingSC titleForSegmentAtIndex:self.eatingSC.selectedSegmentIndex],
                         [self.washingSC titleForSegmentAtIndex:self.washingSC.selectedSegmentIndex],
                         [self.wearingSC titleForSegmentAtIndex:self.wearingSC.selectedSegmentIndex],
                         [self.toiletSC titleForSegmentAtIndex:self.toiletSC.selectedSegmentIndex],
                         [self.activitySC titleForSegmentAtIndex:self.activitySC.selectedSegmentIndex]]
                       ];
    
    [HMFileManager saveObject:array byFileName:@"baseInfoArray"];
    
//    BaseInfo4ViewController *nextStep = [[BaseInfo4ViewController alloc] init];
//    [self.popupController pushViewController:nextStep animated:YES];
    [self.popupController dismiss];
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
