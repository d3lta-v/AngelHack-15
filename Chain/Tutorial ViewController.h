//
//  Tutorial ViewController.h
//  Chain
//
//  Created by Local Admin on 10/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tutorial_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Background;
@property (weak, nonatomic) IBOutlet UIButton *TappedOnScreen;
- (IBAction)TappedScreen:(id)sender;

@end
