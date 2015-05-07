//
//  EditViewController.m
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/5/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@property (strong) NSArray* monthArray;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameCell.textLabel.text = @"meow";
    
}



- (IBAction)btnCancel_clicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dpBirthday_selected:(id)sender {
    NSDate *birthdate = _dpBirthday.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:birthdate];
    _lblBirthday.text = dateString;
}

@end
