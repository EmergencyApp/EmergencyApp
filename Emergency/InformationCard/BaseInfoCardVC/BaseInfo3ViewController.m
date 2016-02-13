//
//  BaseInfo3ViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/10.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfo3ViewController.h"
#import <STPopup/STPopup.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "BaseInfo4ViewController.h"
#import "HMFileManager.h"

#import "InterfaceCustom.h"

@interface BaseInfo3ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nationalityTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *religionTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telPersonalTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *addrTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneHomeTF;

@end

@implementation BaseInfo3ViewController

- (void)loadData {
    NSArray *savedData = (NSArray<NSArray *> *)[HMFileManager getObjectByFileName:@"baseInfoArray"];
    
    if (savedData && savedData[2]) {
        [self.nationalityTF setText:savedData[2][0]];
        [self.religionTF setText:savedData[2][1]];
        [self.telPersonalTF setText:savedData[2][2]];
        [self.addrTF setText:savedData[2][3]];
        [self.phoneHomeTF setText:savedData[2][4]];
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupForms];
    
    [self loadData];
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
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 238);
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
    [self.nationalityTF setPlaceholder:@"民族"];
    [JVFloatLabeledTextField setupTextField:self.nationalityTF];
    [self.nationalityTF setDelegate:self];
    [self.nationalityTF setTag:0];
    
    [self.religionTF setPlaceholder:@"信仰"];
    [JVFloatLabeledTextField setupTextField:self.religionTF];
    [self.religionTF setDelegate:self];
    [self.religionTF setTag:1];
    
    [self.telPersonalTF setPlaceholder:@"本人电话"];
    [JVFloatLabeledTextField setupTextField:self.telPersonalTF];
    [self.telPersonalTF setDelegate:self];
    [self.telPersonalTF setTag:2];
    
    [self.addrTF setPlaceholder:@"家庭住址"];
    [JVFloatLabeledTextField setupTextField:self.addrTF];
    [self.addrTF setDelegate:self];
    [self.addrTF setTag:3];
    
    [self.phoneHomeTF setPlaceholder:@"家庭电话"];
    [JVFloatLabeledTextField setupTextField:self.phoneHomeTF];
    [self.phoneHomeTF setDelegate:self];
    [self.phoneHomeTF setTag:4];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    return YES;
}

#pragma mark - Next

- (void)push {
    BaseInfo4ViewController *nextStep = [[BaseInfo4ViewController alloc] init];
    
    [nextStep setFirstname:self.firstname];
    [nextStep setLastname:self.lastname];
    [nextStep setBirthday:self.birthday];
    [nextStep setAge:self.age];
    [nextStep setSex:self.sex];
    [nextStep setBloodType:self.bloodType];
    
    [nextStep setHeight:self.height];
    [nextStep setWeight:self.weight];
    [nextStep setWaist:self.waist];
    [nextStep setBmi:self.bmi];
    
    [nextStep setNationality:self.nationalityTF.text];
    [nextStep setReligion:self.religionTF.text];
    [nextStep setTelPersonal:self.telPersonalTF.text];
    [nextStep setAddr:self.addrTF.text];
    [nextStep setPhoneHome:self.phoneHomeTF.text];
    
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
