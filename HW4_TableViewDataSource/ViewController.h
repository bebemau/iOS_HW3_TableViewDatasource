//
//  ViewController.h
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/3/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileList.h"

@interface ViewController : UIViewController
@property NSMutableDictionary* items;
@property (strong) IBOutlet ProfileList *profileList;
@end

