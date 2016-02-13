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
#import <Colours/Colours.h>
#import "HMFileManager.h"
#import "SKAudioManager.h"
#import "CoreMediaFuncManagerVC.h"

@interface WarningViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ZLSwipeableView *cardsStackView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *contactsArray;

@end

@implementation WarningViewController {
    CGFloat _brightness;
    NSInteger _tableViewSN;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAudioPlayer *player = [[SKAudioManager shareManager] playingMusic:@"warning_audio"];
    
    self.contactsArray = [HMFileManager getObjectByFileName:@"contactsArray"];
    
    if (!self.contactsArray || self.contactsArray.count==0) {
        self.contactsArray = [[NSMutableArray alloc] init];
    }
    
    self.titleArray = @[@[@"姓名", @"出生日期", @"年龄", @"生理性别", @"血型"],
                        @[@"身高", @"体重", @"腰围", @"BMI"],
                        @[@"民族", @"信仰", @"本人电话", @"家庭住址", @"家庭电话"],
                        @[@"进餐", @"梳洗", @"穿衣", @"如厕", @"活动能力"]
                        ];
    
    _tableViewSN = 0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bt_mymusic_time_bg_afternoon.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [label setCenter:CGPointMake(self.view.frame.size.width/2, 40)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:22]];
    [label setText:@"长按屏幕3秒结束紧急求助"];
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view.
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(100, 100, 100, 100)];
//    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:button];
    
    self.cardsStackView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
    self.cardsStackView.dataSource = self;
    self.cardsStackView.delegate = self;
    [self.cardsStackView setNumberOfActiveViews:4];
    [self.view addSubview:self.cardsStackView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress)];
    [longPress setMinimumPressDuration:3];
    
    [self.cardsStackView addGestureRecognizer:longPress];
}

- (void)longpress {
    [[SKAudioManager shareManager] pauseMusic:@"warning_audio"];
    [self dismiss];
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
    BasicCardView *baseinfocard;
    
    if (_tableViewSN == 5) {
        _tableViewSN -= 5;
    }
    
    switch (_tableViewSN) {
        case 0:{
            baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, 44*(self.contactsArray.count)?self.contactsArray.count:1+68)];
            [baseinfocard.tableView setUserInteractionEnabled:YES];
            [baseinfocard.tableView setScrollEnabled:NO];
            break;
        }
        case 1:
            baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, 44*5+68)];
            break;
        case 2:
            baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, 44*4+68)];
            break;
        case 3:
            baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, 44*5+68)];
            break;
        case 4:
            baseinfocard = [[BasicCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, 44*5+68)];
            break;
        default:
            break;
    }
    
    [baseinfocard.tableView setTag:_tableViewSN++];
    
    if (!baseinfocard.tableView.tag) {
        [baseinfocard.tableView setBackgroundColor:[UIColor whiteColor]];
        [baseinfocard.tableView setSeparatorColor:[UIColor black75PercentColor]];
    } else {
        [baseinfocard.tableView setBackgroundColor:[UIColor black50PercentColor]];
        [baseinfocard.tableView setSeparatorColor:[UIColor whiteColor]];
    }
    
    [baseinfocard.tableView setDelegate:self];
    [baseinfocard.tableView setDataSource:self];
    
    [baseinfocard setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    
    return baseinfocard;
}

#pragma mark - Dismiss

- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[UIScreen mainScreen] setBrightness:_brightness];
}

#pragma mark - Card TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (self.contactsArray.count) {
        [CoreMediaFuncManagerVC call:self.contactsArray[indexPath.row][@"phoneNO"] inViewController:self failBlock:^{
            NSLog(@"不能打");
        }];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (!tableView.tag) {
        
        if (self.contactsArray.count) {
            static NSString *cellID = @"contacts";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
            }
            
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell.detailTextLabel setTextColor:[UIColor blueColor]];
            
            NSString *name = [NSString stringWithFormat:@"%@%@", self.contactsArray[indexPath.row][@"lastname"], self.contactsArray[indexPath.row][@"firstname"]];
            [cell.textLabel setText:name];
            [cell.detailTextLabel setText:self.contactsArray[indexPath.row][@"phoneNO"]];
            
            return cell;
        } else {
            static NSString *cellID = @"empty";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell.detailTextLabel setTextColor:[UIColor blueColor]];
            
            [cell.textLabel setText:@"未设置紧急联系人"];
            
            return cell;
        }
        
    } else {
        static NSString *cellID = @"warningCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
        }
        
        [cell setBackgroundColor:[UIColor black50PercentColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        
        //    [cell.textLabel setText:@"title"];
        //    [cell.detailTextLabel setText:@"detail"];
        
        NSArray *savedData = (NSArray<NSArray *> *)[HMFileManager getObjectByFileName:@"baseInfoArray"];
        
        [cell.textLabel setText:self.titleArray[tableView.tag-1][indexPath.row]];
        [cell.detailTextLabel setText:savedData[tableView.tag-1][indexPath.row]];
        
        return cell;

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 0:
            return self.contactsArray.count?self.contactsArray.count:1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 5;
            break;
        case 4:
            return 5;
            break;
        default:
            return 0;
            break;
    }
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

