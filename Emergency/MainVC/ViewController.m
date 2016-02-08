//
//  AppDelegate.m
//  Emergency
//
//  Created by 孙恺 on 16/2/6.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "ViewController.h"
#import "WKSectionView.h"
#import "WarningViewController.h"

#import "BaseInfoViewController.h"
#import <STPopup/STPopup.h>

#define TABLEVIEW_PULL_RATE 0.6

#define DEVICE_SCREEN_HEIGHT self.view.frame.size.height
#define DEVICE_SCREEN_WIDTH self.view.frame.size.width

#define TABLEVIEW_CONTENTINSET_TOP DEVICE_SCREEN_HEIGHT*TABLEVIEW_PULL_RATE
#define PANVIEW_SIZE_HEIGHT TABLEVIEW_CONTENTINSET_TOP+22
#define TABLEVIEW_HIDE_CONTENTSETOFFY -TABLEVIEW_CONTENTINSET_TOP-(DEVICE_SCREEN_HEIGHT/7)

#define PANVIEW_INCATORLABEL_PADDING 62

#define TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL 0.3



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate> {
    UIImageView  *_backImageView;
    UITableView *_tableView;
    UIView *_panView;
    UILabel *_incatorLabel;
    BOOL _hide;
    CGFloat _lastPosition;
}
@end

@implementation ViewController

#pragma mark - Lifecycle

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_hide) {
        _panView.hidden = NO;
//        _incatorLabel.hidden = NO;
        _hide = NO;
        [_tableView setContentOffset:CGPointMake(0, -TABLEVIEW_CONTENTINSET_TOP) animated:YES];
        [UIView animateWithDuration:TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL animations:^{
            UIEdgeInsets edgeInset = UIEdgeInsetsMake(TABLEVIEW_CONTENTINSET_TOP, 0, 0, 0);
            _tableView.contentInset = edgeInset;
            [_tableView setContentOffset:CGPointMake(0, -TABLEVIEW_CONTENTINSET_TOP) animated:YES];
            [_tableView scrollsToTop];
            _panView.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
            
            [_incatorLabel setCenter:CGPointMake(_panView.frame.size.width/2, _panView.frame.size.height-PANVIEW_INCATORLABEL_PADDING)];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tableViewSetup];
    _hide = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView

- (void)tableViewSetup {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(TABLEVIEW_CONTENTINSET_TOP, 0, 0, 0);
    _tableView.contentInset = edgeInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = [self backViewForTableView];
    [self.view addSubview:_tableView];
    
}

- (UIView *)backViewForTableView {
    UIView * backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backImageView = [[UIImageView alloc] initWithFrame:backView.bounds];
    _backImageView.image = [UIImage imageNamed:@"bt_mymusic_time_bg_afternoon.jpg"];
    _panView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT)];
    _panView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:32.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
    
    _incatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 44)];
    [_incatorLabel setText:@"紧急情况请向下拉动"];
    [_incatorLabel setTextAlignment:NSTextAlignmentCenter];
    [_incatorLabel setTextColor:[UIColor whiteColor]];
    [_incatorLabel setFont:[UIFont systemFontOfSize:26]];
    [_panView addSubview:_incatorLabel];
    [_incatorLabel setCenter:CGPointMake(_panView.frame.size.width/2, _panView.frame.size.height-PANVIEW_INCATORLABEL_PADDING)];
    
    [_backImageView addSubview:_panView];
    [backView addSubview:_backImageView];
    return backView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseInfoViewController *baseInfoVC = [[BaseInfoViewController alloc] init];
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:baseInfoVC];
    
    [popupController.navigationBar setBarTintColor:[tableView cellForRowAtIndexPath:indexPath].backgroundColor];
    [popupController.navigationBar setAlpha:1];
    [popupController.navigationBar setTintColor:[UIColor whiteColor]];
    [popupController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [popupController.containerView.layer setCornerRadius:10.0f];
    
    if (NSClassFromString(@"UIBlurEffect")) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        popupController.backgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    
    [popupController presentInViewController:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"基本信息"];
            break;
        case 1:
            [cell.textLabel setText:@"家族及遗传病史"];
            break;
        case 2:
            [cell.textLabel setText:@"慢性病"];
            break;
        case 3:
            [cell.textLabel setText:@"药物使用记录"];
            break;
        case 4:
            [cell.textLabel setText:@"过敏反应"];
            break;
        case 5:
            [cell.textLabel setText:@"医疗记录"];
            break;
        case 6:
            [cell.textLabel setText:@"生活习惯"];
            break;
        case 7:
            [cell.textLabel setText:@"免疫接种记录"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WKSectionView *sectionView = [[WKSectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 120)];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - Scrolling Animation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (_hide) {
        return;
    }
    if (contentOffsetY >= -TABLEVIEW_CONTENTINSET_TOP) {
        _backImageView.frame = CGRectMake(0, -contentOffsetY-TABLEVIEW_CONTENTINSET_TOP, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
        _tableView.showsVerticalScrollIndicator = YES;
    }
    else {
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = YES;
    }
    if (contentOffsetY <= -TABLEVIEW_CONTENTINSET_TOP) {
        if (!_hide) {
            if (scrollView.isDragging) {
                [UIView animateWithDuration:TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL animations:^{
                    _panView.frame = CGRectMake(0, (contentOffsetY+TABLEVIEW_CONTENTINSET_TOP), DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
                }];
            }
            else {
                _panView.frame = CGRectMake(0, (contentOffsetY+TABLEVIEW_CONTENTINSET_TOP), DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
            }
        }
    }
    else {
        _panView.frame = CGRectMake(0, 0,DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
    }
    _lastPosition = contentOffsetY;
    
    if (contentOffsetY < TABLEVIEW_HIDE_CONTENTSETOFFY) {
        
        // TODO: Label animation.
        [_incatorLabel setText:@"松开呼叫帮助"];
        
    } else {
        
        [_incatorLabel setText:@"紧急情况请向下拉动"];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < TABLEVIEW_HIDE_CONTENTSETOFFY) {
        if (!_hide) {
            _hide = YES;
            [UIView animateWithDuration:TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL animations:^{
                _panView.frame = CGRectMake(0, -0,DEVICE_SCREEN_WIDTH, 0);
                
                UIEdgeInsets edgeInset = UIEdgeInsetsMake(DEVICE_SCREEN_HEIGHT, 0, 0, 0);
                _tableView.contentInset = edgeInset;

                [_tableView scrollRectToVisible:CGRectMake(0, -TABLEVIEW_CONTENTINSET_TOP, DEVICE_SCREEN_WIDTH, TABLEVIEW_CONTENTINSET_TOP/2) animated:YES];
                [_incatorLabel setCenter:CGPointMake(DEVICE_SCREEN_WIDTH/2, _panView.frame.origin.y-PANVIEW_INCATORLABEL_PADDING)];

                
            } completion:^(BOOL finished) {
                if (finished) {
                    _panView.hidden = YES;
                    [self presentViewController:[[WarningViewController alloc] init] animated:NO completion:nil];
                }
            }];
            [scrollView setContentOffset:CGPointMake(0, -DEVICE_SCREEN_HEIGHT) animated:YES];
        }
        return;
    }
}

@end
