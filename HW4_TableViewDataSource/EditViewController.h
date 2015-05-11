//
//  EditViewController.h
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/5/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>

- (void)editViewControllerEntryCompleted:(EditViewController *)vc nameEntered:(NSString *)name birthdayEntered:(NSString*)birthdate;
- (void)editViewControllerDidCancel:(EditViewController *)vc;

@end

@interface EditViewController : UITableViewController

@property (nonatomic, weak) id<EditViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpBirthday;


@end