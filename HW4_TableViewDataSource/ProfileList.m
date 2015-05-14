//
//  ProfileList.m
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/11/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "ProfileList.h"
#import "Profile.h"

@implementation ProfileList

-(void)AddProfile: (NSString*)name birthdate: (NSDate*)date DaysTill:(NSInteger)days{
    Profile *newItem = [[Profile alloc] init];
    newItem.name = name;
    newItem.birthdate = date;
    newItem.daysTill = days;
    
    if(self.profileList == nil)
        self.profileList = [[NSMutableArray alloc] init];
    
    [self.profileList addObject: newItem];
    
    self.profileList = self.getSortedList.mutableCopy;
}

-(void)DeleteProfile:(NSString *)name{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", name];
    NSArray *filtered = [self.profileList filteredArrayUsingPredicate:predicate];
    
    for(Profile* i in filtered)
    {
        [self.profileList removeObject:i];
    }
}

-(void)DeleteProfileAtIndex: (NSUInteger)index{
    [self.profileList removeObjectAtIndex:index];
}

-(NSArray*)getSortedList{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"daysTill"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [self.profileList sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

-(NSInteger)profileCount{
    return self.profileList.count;
}

-(Profile*)profileAtIndex: (NSInteger)index{
    Profile *profile = [self.profileList objectAtIndex:index];
    return profile;
}

@end
