//
//  EditViewController.h
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/5/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpBirthday;


@end
