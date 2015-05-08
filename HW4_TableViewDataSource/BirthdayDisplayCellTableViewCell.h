//
//  BirthdayDisplayCellTableViewCell.h
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/7/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayDisplayCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDaysTill;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;

@end
