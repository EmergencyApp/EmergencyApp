//
//  EmergencyContactManageViewController.m
//  Emergency
//
//  Created by 孙恺 on 16/2/13.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "EmergencyContactManageViewController.h"

#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

#import "CoreMediaFuncManagerVC.h"

@interface EmergencyContactManageViewController ()<UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contactsArray;

@end

@implementation EmergencyContactManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"紧急联系人"];
    
    self.contactsArray = [[NSMutableArray alloc] init];
    
//    [self.contactsArray addObject:@"哈哈"];
//    [self.contactsArray addObject:@"呵呵"];
//    [self.contactsArray addObject:@"额恩"];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section?1:(self.contactsArray.count?self.contactsArray.count:1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (!self.contactsArray.count) {
            
            static NSString *cellID = @"none";
            cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            }
            
            [cell.textLabel setText:@"没有任何紧急联系人"];
        } else {
            
            static NSString *cellID = @"contact";
            cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
            }
            NSString *name = [NSString stringWithFormat:@"%@%@", self.contactsArray[indexPath.row][@"lastname"], self.contactsArray[indexPath.row][@"firstname"]];
            [cell.textLabel setText:name];
            [cell.detailTextLabel setText:self.contactsArray[indexPath.row][@"phoneNO"]];
        }
    } else {
    
        static NSString *cellID = @"contact";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        [cell.textLabel setText:@"添加紧急联系人"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (indexPath.section==1) {
        ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
        nav.peoplePickerDelegate = self;
        if([[UIDevice currentDevice].systemVersion doubleValue]>=8.0){
            nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        }
        [self presentViewController:nav animated:YES completion:nil];
    } else if (self.contactsArray.count) {
        [CoreMediaFuncManagerVC call:self.contactsArray[indexPath.row][@"phoneNO"] inViewController:self failBlock:^{
            NSLog(@"不能打");
        }];
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    ABRecordRef firstname = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABRecordRef lastname = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    NSString *firstnameString = (__bridge NSString *)firstname;
    NSString *lastnameString = (__bridge NSString *)lastname;
    
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    NSLog(@"%@%@", lastnameString, firstnameString);
    
    if (phoneNO.length && (firstnameString.length || lastnameString.length)) {
        [self.contactsArray addObject:@{@"firstname": firstnameString.length?firstnameString:@"",
                                       @"lastname": lastnameString.length?lastnameString:@"",
                                       @"phoneNO": phoneNO}];
        [self.tableView reloadData];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
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
