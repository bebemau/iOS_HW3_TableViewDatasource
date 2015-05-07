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
@property (strong, nonatomic) IBOutlet UITableView *dpBirthday;

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
    _birthdayCell.textLabel.text = @"blah";
}

@end
