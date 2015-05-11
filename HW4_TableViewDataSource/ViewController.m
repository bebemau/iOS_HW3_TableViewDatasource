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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property BOOL automaticEditControlsDidShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //use mutableCopy
    _items = [[NSMutableDictionary alloc]initWithCapacity:2];
    [_items setObject: @"January 18, 2008"  forKey:@"Fluffy"];
    [_items setObject: @"April 28, 2012"  forKey:@"Cheetos"];
}

#pragma tableView

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *keys =[_items allKeys];
        NSString *key = [keys objectAtIndex: indexPath.row];
        [_items removeObjectForKey:key];
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
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *customCellID = @"tableCell";
    NSArray* allKeys = [_items allKeys];
    NSString *name = [allKeys objectAtIndex:indexPath.row];
    id value = [_items objectForKey: name];
    NSDate *birthdate = [self GetDateObject:value];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:birthdate];
    NSInteger difference = [self CalculateDays: birthdate];

    BirthdayDisplayCellTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier: customCellID];
    customCell.lblBirthday.text = dateString;
    customCell.lblDaysTill.text = [NSString stringWithFormat:@"%ld", (long)difference];
    customCell.lblName.text = name;
    
    return customCell;

}

#pragma mark - EditViewController
-(void)editViewControllerEntryCompleted:(EditViewController *)vc nameEntered:(NSString *)name birthdayEntered:(NSString *)birthdate{
    //add to array
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        RecipeDetailViewController *destViewController = segue.destinationViewController;
//        destViewController.recipe = recipe;
//    }
//}

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
    if([comingBirthday earlierDate: [NSDate date]]){
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

@end


