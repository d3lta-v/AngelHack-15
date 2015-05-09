//
//  MapsViewController.m
//  Chain
//
//  Created by Pan Ziyue on 9/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController ()

@end

@implementation MapsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Determine Condition Values
    NSString *one = @"1";
    NSString *two = @"2";
    // Retrieve Value (1, 2, 3) That determines location. Key = "currentLocation"
    NSString *location = [ [NSUserDefaults standardUserDefaults]stringForKey:@"currentLocation"];
    //If location is one
        if ([location isEqualToString:one])
        {
            //Display Image as map with one highlighted
            //UIImage *map = [UIImage imageNamed:@"map1"];
        }
        else if ([location isEqualToString:two])
        {
            //Display Image as map with two highlighted
            //UIImage *map = [UIImage imageNamed:@"map2"];
        }
        else
        {
            //Display Image as map with three highlited
            //UIImage *map = [UIImage imageNamed:@"map3"];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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