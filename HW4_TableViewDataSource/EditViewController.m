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
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@end


@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *date = [dateFormat dateFromString:@"1/1/1960"];
    self.dpBirthday.minimumDate = date;
    date = [dateFormat dateFromString:@"12/31/2000"];
    self.dpBirthday.maximumDate = date;
    self.dpBirthday.datePickerMode = UIDatePickerModeDate;
}



- (IBAction)btnCancel_clicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dpBirthday_selected:(id)sender {
    NSDate *birthdate = _dpBirthday.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    //dateFormat setLocale
    NSString *dateString = [dateFormat stringFromDate:birthdate];
    _lblBirthday.text = dateString;
}

- (IBAction)btnDone_clicked:(id)sender {
    //if ([self.delegate respondsToSelector:@selector(editViewControllerEntryCompleted:)]) {
        [self.delegate editViewControllerEntryCompleted:self nameEntered:self.txtName.text birthdayEntered:_lblBirthday.text];
    //}else{
       [self dismissViewControllerAnimated:YES completion:nil];
    //}
}

@end
