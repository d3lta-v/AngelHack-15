//
//  CheckoutViewController.m
//  Chain
//
//  Created by Local Admin on 9/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import "CheckoutViewController.h"

@interface CheckoutViewController ()

@end

@implementation CheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // load the values
    /* values
     Item bought or not,
     */
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceName"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
/*
 NSUserDefaults
 To Save :
 NSString *valueToSave = @"someValue";
 [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
 [[NSUserDefaults standardUserDefaults] synchronize];
 To Retrieve :
 NSString *savedValue = [[NSUserDefaults standardUserDefaults]
 stringForKey:@"preferenceName"];
 For Int :
 //[[NSUserDefaults standardUserDefaults] setInteger:HighScore forKey:@"HighScore"];
 ////NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
 */