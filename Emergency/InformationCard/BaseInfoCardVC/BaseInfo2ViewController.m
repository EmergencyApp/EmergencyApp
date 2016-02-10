//
//  BaseInfo2ViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/8.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfo2ViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <STPopup/STPopup.h>
#import <Colours/Colours.h>

@interface BaseInfo2ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *heightTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *weightTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *waistTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *bmiTF;

@end

@implementation BaseInfo2ViewController

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
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 266);
        self.landscapeContentSizeInPopup = CGSizeMake(screenSize.height/5*4, screenSize.width/5*3);
    }
    return self;
}

#pragma mark - Setup forms UI

- (void)setupNavigationItem {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    [self.navigationItem setRightBarButtonItem:button];
}

- (void)setupForms {
    NSLog(@"kk");
    
    [self.heightTF setPlaceholder:@"身高"];
    [self setupTextField:self.heightTF];
    [self.heightTF setDelegate:self];
//    [self.heightTF addTarget:self action:@selector(heightTFTouch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.weightTF setPlaceholder:@"体重"];
    [self setupTextField:self.weightTF];
    
    [self.waistTF setPlaceholder:@"腰围"];
    [self setupTextField:self.waistTF];
    
    [self.bmiTF setPlaceholder:@"BMI"];
    [self setupTextField:self.bmiTF];
}

- (void)setupTextField:(JVFloatLabeledTextField *)textField {
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setTintColor:[UIColor whiteColor]];
    [textField setTextColor:[UIColor whiteColor]];
    [textField setFloatingLabelTextColor:[UIColor whiteColor]];
    [textField setValue:[UIColor black75PercentColor] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    [self heightTFTouch];
    return NO;
}

#pragma mark - Next

- (void)push {
    BaseInfo2ViewController *nextStep = [[BaseInfo2ViewController alloc] init];
    [self.popupController pushViewController:nextStep animated:YES];
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
