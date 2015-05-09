//
//  BeaconViewController.h
//  Chain
//
//  Created by Pan Ziyue & Dalton on 9/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconViewController : UIViewController <CLLocationManagerDelegate, CBCentralManagerDelegate>

// Managers
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CBCentralManager *bluetoothManager;

// Outlets
@property (strong, nonatomic) IBOutlet UIView *containerView;

// Buttons (IBActions)
@property (strong, nonatomic) IBOutlet UIButton *mapsButtonPressed;
@property (strong, nonatomic) IBOutlet UIButton *announceButtonPressed;
@property (strong, nonatomic) IBOutlet UIButton *cartButtonPressed;


@end
