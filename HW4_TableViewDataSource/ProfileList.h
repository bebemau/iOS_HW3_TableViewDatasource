//
//  ProfileList.h
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/11/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"

@interface ProfileList : NSObject
@property (nonatomic, readwrite) NSMutableArray *profileList;
-(void)AddProfile: (NSString*)name birthdate: (NSDate*)date;
-(void)DeleteProfile: (NSString*)name;
-(NSArray*) getSortedList;
-(void)DeleteProfileAtIndex: (NSUInteger)index;
-(NSInteger)profileCount;
-(Profile*)profileAtIndex: (NSInteger)index;
@end
