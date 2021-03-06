//
//  BaseInfo2ViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/8.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "BaseInfo2ViewController.h"
#import "BaseInfo3ViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <STPopup/STPopup.h>
#import <Colours/Colours.h>
#import <NYSegmentedControl/NYSegmentedControl.h>
#import "HMFileManager.h"

#import "InterfaceCustom.h"

@interface BaseInfo2ViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *heightTF;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *heightSC;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *weightTF;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *weightSC;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *waistTF;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *waistSC;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *bmiTF;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *bmiSC;

@end

@implementation BaseInfo2ViewController

- (void)loadData {
    NSArray *savedData = (NSArray<NSArray *> *)[HMFileManager getObjectByFileName:@"baseInfoArray"];
    
    if (savedData && savedData[1]) {
        [self.heightTF setText:savedData[1][0]];
        [self.weightTF setText:savedData[1][1]];
        [self.waistTF setText:savedData[1][2]];
        [self.bmiTF setText:savedData[1][3]];
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
        
        self.contentSizeInPopup = CGSizeMake(screenSize.width/5*4, 202);
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
    [self.heightTF setPlaceholder:@"身高"];
    [JVFloatLabeledTextField setupTextField:self.heightTF];
    [self.heightTF addTarget:self action:@selector(bmiChanged) forControlEvents:UIControlEventEditingChanged];
    [self.heightSC insertSegmentWithTitle:@"英尺" atIndex:0];
    [self.heightSC insertSegmentWithTitle:@"厘米" atIndex:0];
    [self.heightSC reloadData];
    [NYSegmentedControl setupSegmentControl:self.heightSC];
    [self.heightSC addTarget:self action:@selector(bmiChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.weightTF setPlaceholder:@"体重"];
    [JVFloatLabeledTextField setupTextField:self.weightTF];
    [self.weightTF addTarget:self action:@selector(bmiChanged) forControlEvents:UIControlEventEditingChanged];
    [self.weightSC insertSegmentWithTitle:@"磅" atIndex:0];
    [self.weightSC insertSegmentWithTitle:@"公斤" atIndex:0];
    [self.weightSC reloadData];
    [NYSegmentedControl setupSegmentControl:self.weightSC];
    [self.weightSC addTarget:self action:@selector(bmiChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.waistTF setPlaceholder:@"腰围"];
    [JVFloatLabeledTextField setupTextField:self.waistTF];
    [self.waistSC insertSegmentWithTitle:@"英尺" atIndex:0];
    [self.waistSC insertSegmentWithTitle:@"市尺" atIndex:0];
    [self.waistSC insertSegmentWithTitle:@"厘米" atIndex:0];
    [self.waistSC reloadData];
    [NYSegmentedControl setupSegmentControl:self.waistSC];
    
    [self.bmiTF setPlaceholder:@"BMI"];
    [JVFloatLabeledTextField setupTextField:self.bmiTF];
    [self.bmiTF setEnabled:NO];
    [self.bmiSC insertSegmentWithTitle:@"BMI" atIndex:0];
    [self.bmiSC reloadData];
    [NYSegmentedControl setupSegmentControl:self.bmiSC];
}

#pragma mark - BMI changed

- (void)bmiChanged {
    
    if (self.weightTF.text.floatValue != 0 && self.heightTF.text.floatValue != 0) {
        
        float heightMeter = 0;
        if (self.heightSC.selectedSegmentIndex) {
            heightMeter += self.heightTF.text.floatValue * 0.3048;
        } else {
            heightMeter += self.heightTF.text.floatValue / 100;
        }
        
        float weightKG = 0;
        if (self.weightSC.selectedSegmentIndex) {
            weightKG += self.weightTF.text.floatValue * 0.4535924;
        } else {
            weightKG += self.weightTF.text.floatValue;
        }
        
        [self.bmiTF setText:[NSString stringWithFormat:@"%.2f",weightKG/(heightMeter*heightMeter)]];
        
    } else {
        
        [self.bmiTF setText:@""];
        
    }
}

#pragma mark - Next

- (void)push {
    BaseInfo3ViewController *nextStep = [[BaseInfo3ViewController alloc] init];
    
    [nextStep setFirstname:self.firstname];
    [nextStep setLastname:self.lastname];
    [nextStep setBirthday:self.birthday];
    [nextStep setAge:self.age];
    [nextStep setSex:self.sex];
    [nextStep setBloodType:self.bloodType];
    
    [nextStep setHeight:self.heightTF.text];
    [nextStep setWeight:self.weightTF.text];
    [nextStep setWaist:self.waistTF.text];
    [nextStep setBmi:self.bmiTF.text];
    
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
