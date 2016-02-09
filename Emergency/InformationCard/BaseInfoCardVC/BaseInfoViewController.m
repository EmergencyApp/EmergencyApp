//
//  BaseInfoViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/8.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "BaseInfo2ViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <NYSegmentedControl/NYSegmentedControl.h>
#import <STPopup/STPopup.h>
#import <Colours/Colours.h>
#import <DateTools/DateTools.h>

@interface BaseInfoViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *sexPicker;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *firstNameTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *birthdayTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *sexTF;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *bloodRHSC;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *bloodTypeSC;
@property (weak, nonatomic) IBOutlet UILabel *bloodTypeTitleLabel;

@end

@implementation BaseInfoViewController

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 266);
        self.landscapeContentSizeInPopup = CGSizeMake(screenSize.height/5*4, screenSize.width/5*3);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.ageLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.ageLabel removeObserver:self forKeyPath:@"text"];
}

#pragma mark - Age Label KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [((UILabel *)object) setTextColor:[UIColor whiteColor]];
    }
}

#pragma mark - Birthday TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self birthdayDatePickerChange];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self birthdayDatePickerChange];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self.ageLabel setText:@"年龄"];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self birthdayDatePickerChange];
    return YES;
}

#pragma mark - SexPicker Delegate and Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *sexArray = @[@"男", @"女", @"无性别", @"双性别", @"其它"];
    return sexArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *sexArray = @[@"男", @"女", @"无性别", @"双性别", @"其它"];
    [self.sexTF setText:sexArray[row]];
}

#pragma mark - DatePicker and segmentControl changed

- (void)birthdayDatePickerChange {
    [self.birthdayTF setText:[self.datePicker.date formattedDateWithFormat:@"yyyy-MM-dd"]];
    [self.ageLabel setText:[NSString stringWithFormat:@"%li岁", [[NSDate date] yearsFrom:self.datePicker.date]]];
}
     
- (void)bloodTypeChanged {
    if (self.bloodTypeSC.selectedSegmentIndex != 0 || self.bloodRHSC.selectedSegmentIndex != 0) {
        [self.bloodTypeTitleLabel setTextColor:[UIColor whiteColor]];
    } else {
        [self.bloodTypeTitleLabel setTextColor:[UIColor black75PercentColor]];
    }
}

#pragma mark - Setup forms UI

- (void)setupNavigationItem {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    [self.navigationItem setRightBarButtonItem:button];
}

- (void)setupForms {
    [self.firstNameTF setPlaceholder:@"姓"];
    [self setupTextField:self.firstNameTF];
    
    [self.lastNameTF setPlaceholder:@"名"];
    [self setupTextField:self.lastNameTF];
    
    [self.birthdayTF setPlaceholder:@"出生日期"];
    [self setupTextField:self.birthdayTF];
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setMaximumDate:[NSDate date]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(birthdayDatePickerChange) forControlEvents:UIControlEventValueChanged];
    [self.birthdayTF setInputView:self.datePicker];
    [self.birthdayTF setDelegate:self];
    
    [self.sexTF setPlaceholder:@"生理性别"];
    self.sexPicker = [[UIPickerView alloc] init];
    [self.sexPicker setDelegate:self];
    [self.sexPicker setDataSource:self];
    [self setupTextField:self.sexTF];
    [self.sexTF setInputView:self.sexPicker];
    
    [self.ageLabel setTextColor:[UIColor black75PercentColor]];
    [self.ageLabel setText:@"年龄"];
    
    [self.bloodTypeTitleLabel setTextColor:[UIColor black75PercentColor]];
    [self.bloodTypeTitleLabel setText:@"血型"];
    [self.bloodTypeTitleLabel setFont:[UIFont systemFontOfSize:10]];
    
    [self.bloodTypeSC insertSegmentWithTitle:@"AB型" atIndex:0];
    [self.bloodTypeSC insertSegmentWithTitle:@"O型" atIndex:0];
    [self.bloodTypeSC insertSegmentWithTitle:@"B型" atIndex:0];
    [self.bloodTypeSC insertSegmentWithTitle:@"A型" atIndex:0];
    [self.bloodTypeSC insertSegmentWithTitle:@"不详" atIndex:0];
    [self.bloodTypeSC reloadData];
    [self setupSegmentControl:self.bloodTypeSC];
    [self.bloodTypeSC setTag:998];
    
    [self.bloodRHSC insertSegmentWithTitle:@"RH阴性" atIndex:0];
    [self.bloodRHSC insertSegmentWithTitle:@"非RH阴性" atIndex:0];
    [self.bloodRHSC insertSegmentWithTitle:@"不详" atIndex:0];
    [self.bloodRHSC reloadData];
    [self setupSegmentControl:self.bloodRHSC];
    [self.bloodRHSC setTag:999];
    
    [self.bloodRHSC addTarget:self action:@selector(bloodTypeChanged) forControlEvents:UIControlEventValueChanged];
    [self.bloodTypeSC addTarget:self action:@selector(bloodTypeChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)setupSegmentControl:(NYSegmentedControl *)segmentControl {
    segmentControl.backgroundColor = [UIColor clearColor];
    segmentControl.borderColor = [UIColor clearColor];
    segmentControl.segmentIndicatorBorderColor = [UIColor clearColor];
    segmentControl.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    segmentControl.segmentIndicatorInset = 0.0f;
    segmentControl.titleTextColor = [UIColor lightGrayColor];
    segmentControl.selectedTitleTextColor = [UIColor darkGrayColor];
    [segmentControl sizeToFit];
}

- (void)setupTextField:(JVFloatLabeledTextField *)textField {
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setTintColor:[UIColor whiteColor]];
    [textField setTextColor:[UIColor whiteColor]];
    [textField setFloatingLabelTextColor:[UIColor whiteColor]];
    [textField setValue:[UIColor black75PercentColor] forKeyPath:@"_placeholderLabel.textColor"];
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
