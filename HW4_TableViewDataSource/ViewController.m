//
//  ViewController.m
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/3/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "ViewController.h"
#import "BirthdayDisplayCellTableViewCell.h"
#import "EditViewController.h"
#import "ProfileList.h"
#import "Profile.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, EditViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property BOOL automaticEditControlsDidShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileList = [[ProfileList alloc] init];
    NSDate *birthDate = [self GetDateObject:@"January 18, 2008"];
    NSInteger daysTill = [self CalculateDays:birthDate];
    [self.profileList AddProfile:@"Fluffy" birthdate: birthDate DaysTill:daysTill];
    birthDate = [self GetDateObject:@"October 28, 2012"];
    daysTill = [self CalculateDays:birthDate];
    [self.profileList AddProfile:@"Cheetos" birthdate: birthDate DaysTill:daysTill];
}

#pragma tableView

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.profileList DeleteProfileAtIndex:indexPath.row];
        [self.tblItems reloadData];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing: editing animated: animated];
    
    const UIBarButtonSystemItem systemItem = editing ? UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit;
    
    UIBarButtonItem *const newButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem: systemItem
     target: self
     action: @selector(toggleEditing:)];
    
    [self.navigationItem setRightBarButtonItems: @[newButton] animated: YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (self.editing && row == 0) {
        if (_automaticEditControlsDidShow)
            return UITableViewCellEditingStyleInsert;
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [_items count];
    return [self.profileList profileCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *customCellID = @"tableCell";
    Profile *profile = [self.profileList profileAtIndex:indexPath.row];
    NSString *name = profile.name;
    NSDate *birthdate = profile.birthdate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:birthdate];
//    NSInteger difference = [self CalculateDays: birthdate];
    NSInteger daysTill = profile.daysTill;
    
    BirthdayDisplayCellTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier: customCellID];
    customCell.lblBirthday.text = dateString;
    //customCell.lblDaysTill.text = [NSString stringWithFormat:@"%ld", (long)difference];
    customCell.lblDaysTill.text = [NSString stringWithFormat: @"%ld", daysTill];
    customCell.lblName.text = name;
    
    return customCell;

}

#pragma mark - EditViewController
-(void)editViewControllerEntryCompleted:(EditViewController *)vc nameEntered:(NSString *)name birthdayEntered:(NSString *)birthdate{
    //add to array
    NSDate *date = [self GetDateObject:birthdate];
    NSInteger days = [self CalculateDays:date];
    [self.profileList AddProfile:name birthdate:date DaysTill:days];
    [self.tblItems reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    EditViewController *editViewController = (EditViewController *)navigationController.topViewController;
    
    editViewController.delegate = self;
}

-(NSDate*)GetDateObject: (NSString*)dateInput{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy"];
    NSDate *output = [df dateFromString:dateInput];
    
    return output;
}

-(NSInteger)CalculateDays:(NSDate*)birthday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear  fromDate:birthday];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear  fromDate:[NSDate date]];
    [components setYear: [todayComponents year]];
    NSDate *comingBirthday = [calendar dateFromComponents:components];
    
    if([comingBirthday compare:[NSDate date]] == NSOrderedAscending){
        [components setYear: [todayComponents year] + 1];
        comingBirthday = [calendar dateFromComponents:components];
    }
        
    return [self daysBetweenDate: [NSDate date] andDate:comingBirthday];
}

- (IBAction)toggleEditing:(id)sender {
    [self.tblItems setEditing: !self.editing];
    [self setEditing: !self.editing animated: YES];
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay                                          fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

-(void)RefreshTable{
    [self.tblItems reloadData];
}

@end


