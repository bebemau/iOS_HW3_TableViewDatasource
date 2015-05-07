//
//  ViewController.m
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/3/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property BOOL automaticEditControlsDidShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _items = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSDate* date = [self GetDateObject:@"1/18/2008"];
    [_items setObject: date  forKey:@"Fluffy"];
    date = [self GetDateObject:@"4/28/2012"];
    [_items setObject: date  forKey:@"Cheetos"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    
    NSArray* allKeys = [_items allKeys];
    id value = [_items objectForKey:[allKeys objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", value];
    return cell;
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
    [df setDateFormat:@"MM/dd/yyyy"];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSDate *output = [df dateFromString:dateInput];
    return output;
}

- (IBAction)toggleEditing:(id)sender {
    [self.tblItems setEditing: !self.editing];
    [self setEditing: !self.editing animated: YES];
}

@end


