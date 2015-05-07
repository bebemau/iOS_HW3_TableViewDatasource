//
//  EditViewController.m
//  HW4_TableViewDataSource
//
//  Created by Man, Keren on 5/5/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - UIPickerViewDelegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return 12;
    }
    else if (component == 1){
        return 31;
    }
    else
        return 10;
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"blah";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

@end
