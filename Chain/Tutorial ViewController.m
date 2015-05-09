//
//  Tutorial ViewController.m
//  Chain
//
//  Created by Local Admin on 10/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import "Tutorial ViewController.h"

@interface Tutorial_ViewController ()

@end

@implementation Tutorial_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *Taps = @"0";
    [[NSUserDefaults standardUserDefaults] setObject:Taps forKey:@"Taps"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TappedScreen:(id)sender
{
    NSInteger Taps = [[NSUserDefaults standardUserDefaults] integerForKey:@"Taps"];
    if (Taps == 0)
    {
        self.Background.image = [UIImage imageNamed:@"Tutorial02.png"]; // Load 2
    }
    else if (Taps == 1)
    {
        self.Background.image = [UIImage imageNamed:@"Tutorial03.png"]; // Load 3
    }
    else if (Taps == 2)
    {
        self.Background.image = [UIImage imageNamed:@"Tutorial04.png"]; // Load 4
    }
    else if (Taps == 3)
    {
        self.Background.image = [UIImage imageNamed:@"Tutorial05.png"]; // Load 5
    }
    else
    {
        [self performSegueWithIdentifier:@"FirstSegue" sender:sender];
    }
    NSInteger NewTaps = Taps + 1;
    [[NSUserDefaults standardUserDefaults] setInteger:NewTaps forKey:@"Taps"];
}
@end
/*
 double delayInSeconds = 2.0;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
 NSLog(@"Do some work");
 });
*/
/*
 //Check If first time
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 if (![defaults objectForKey:@"firstRun"])
 [defaults setObject:[NSDate date] forKey:@"firstRun"];
 
 [[NSUserDefaults standardUserDefaults] synchronize];
 */
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
 //[imageView setImage:image];
 */