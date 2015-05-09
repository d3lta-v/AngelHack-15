//
//  BeaconViewController.m
//  Chain
//
//  Created by Pan Ziyue & Dalton on 9/5/15.
//  Copyright (c) 2015 StatiX Industries. All rights reserved.
//

#import "BeaconViewController.h"

@interface BeaconViewController ()
{
    NSString *locationString;
    NSString *linkURL;
    bool inRegion;
    
    UIImageView *noBeaconsView;
}

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Load Values for items
#warning Values Of items
    NSString *DaltonCount = @"0"; // Number of product user wants to buy
    NSString *DaltonPrice = @"135"; // Price in Dollars
    
    NSString *ZiyueCount = @"0"; // Number of product user wants to buy
    NSString *ZiyuePrice = @"25"; // Price in Dollars
    
    NSString *SiddhantCount = @"0"; // Number of product user wants to buy
    NSString *SiddhantPrice = @"45"; // Price in Dollars
    
    NSString *LhuCount = @"0"; // Number of product user wants to buy
    NSString *LhuPrice = @"195"; // Price in Dollars
    
    NSString *DingWenCount = @"0"; // Number of product user wants to buy
    NSString *DingWenPrice = @"45"; // Price in Dollars
    
    NSString *imacCount = @"0"; // Number of product user wants to buy
    NSString *imacPrice = @"3388"; // Price in Dollars
    
    NSString *mbaCount = @"0"; // Number of product user wants to buy
    NSString *mbaPrice = @"1328"; // Price in Dollars
    
    NSString *mbpCount = @"0"; // Number of product user wants to buy
    NSString *mbpPrice = @"2688"; // Price in Dollars
    
    NSString *MacMiniCount = @"0"; // Number of product user wants to buy
    NSString *MacMiniPrice = @"1328"; // Price in Dollars
    
    NSString *MacProCount = @"0"; // Number of product user wants to buy
    NSString *MacProPrice = @"2688"; // Price in Dollars
    
    NSString *JurvisCount = @"0"; // Number of product user wants to buy
    NSString *JurvisPrice = @"149"; // Price in Dollars
    
    NSString *AureliusCount = @"0"; // Number of product user wants to buy
    NSString *AureliusPrice = @"579"; // Price in Dollars
    
    NSString *AxiosCount = @"0"; // Number of product user wants to buy
    NSString *AxiosPrice = @"45"; // Price in Dollars
    
    NSString *YoshiCount = @"0"; // Number of product user wants to buy
    NSString *YoshiPrice = @"359"; // Price in Dollars
    
    NSString *ShiHuiCount = @"0"; // Number of product user wants to buy
    NSString *ShiHuiPrice = @"88"; // Price in Dollars
    //Saving all these values to NSUserDefaults for retrieval
    [[NSUserDefaults standardUserDefaults] setObject:DaltonCount forKey:@"DC"];
    [[NSUserDefaults standardUserDefaults] setObject:DaltonPrice forKey:@"DP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:ZiyueCount forKey:@"ZC"];
    [[NSUserDefaults standardUserDefaults] setObject:ZiyuePrice forKey:@"ZP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:SiddhantCount forKey:@"SC"];
    [[NSUserDefaults standardUserDefaults] setObject:SiddhantPrice forKey:@"SP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:LhuCount forKey:@"LC"];
    [[NSUserDefaults standardUserDefaults] setObject:LhuPrice forKey:@"LP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:DingWenCount forKey:@"DWC"];
    [[NSUserDefaults standardUserDefaults] setObject:DingWenPrice forKey:@"DWP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:imacCount forKey:@"IMDC"];
    [[NSUserDefaults standardUserDefaults] setObject:imacPrice forKey:@"IMDP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:mbaCount forKey:@"MBAC"];
    [[NSUserDefaults standardUserDefaults] setObject:mbaPrice forKey:@"MBAP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:mbpCount forKey:@"MBPC"];
    [[NSUserDefaults standardUserDefaults] setObject:mbpPrice forKey:@"MBPP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:MacMiniCount forKey:@"MMC"];
    [[NSUserDefaults standardUserDefaults] setObject:MacMiniPrice forKey:@"MMP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:MacProCount forKey:@"MPC"];
    [[NSUserDefaults standardUserDefaults] setObject:MacProPrice forKey:@"MPP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:JurvisCount forKey:@"JC"];
    [[NSUserDefaults standardUserDefaults] setObject:JurvisPrice forKey:@"JP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:AureliusCount forKey:@"AC"];
    [[NSUserDefaults standardUserDefaults] setObject:AureliusPrice forKey:@"AP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:AxiosCount forKey:@"AXC"];
    [[NSUserDefaults standardUserDefaults] setObject:AxiosPrice forKey:@"AXP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:YoshiCount forKey:@"YC"];
    [[NSUserDefaults standardUserDefaults] setObject:YoshiPrice forKey:@"YP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:ShiHuiCount forKey:@"SHC"];
    [[NSUserDefaults standardUserDefaults] setObject:ShiHuiPrice forKey:@"SHP"];
#warning END OF Values Of items
    // Init no beacons view
    noBeaconsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NoBeacons"]];
    noBeaconsView.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height); // May be buggy, I have no idea on x,y coords for implementing with overlaying containerView
    
    // Check if bluetooth is on or off
    [self startBluetoothStatusMonitoring];
    
    // Initialize the location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    //self.locationManager.avoidUnknownStateBeacons = YES;
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"775752A9-F236-4619-9562-84AC9DE124C6"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:@"Estimote Region"];
    
    // Start monitoring
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
}

#pragma mark - CLLocationManager delegate

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    // Did enter region
    NSLog(@"didEnterRegion Triggered!");
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    [self.view addSubview:noBeaconsView];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    // No signal
    NSLog(@"didExitRegion Triggered! Stopping ranging services...");
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    if ([self.view.subviews containsObject:noBeaconsView]) {
        [noBeaconsView removeFromSuperview];
    }
}

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.myBeaconRegion];
}

- (void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside: {
            NSLog(@"Inside region, beginning ranging");
            [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
            if ([self.view.subviews containsObject:noBeaconsView]) {
                [noBeaconsView removeFromSuperview];
            }
        }
            break;
        case CLRegionStateOutside: {
            NSLog(@"Outside region");
            // No beacons are in range
            [self.view addSubview:noBeaconsView];
        }
            break;
        case CLRegionStateUnknown:
            NSLog(@"State unknown");
            break;
        default:
            // stop ranging beacons, etc
            NSLog(@"Region unknown");
    }
}

- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count]>0) {
        // Detect amount of beacons in range
        
        // Get the nearest found beacon
        //beacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity != %d", CLProximityUnknown]];
        //beacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity != %d", -1]];
        //if (beacons.count==0) {
        //TODO: Finish this catching mechanism
        if (false) {
            
        } else {
            CLBeacon *foundBeacon = [beacons firstObject];
            
            // All the beacon parameters here
            //NSString *uuid = foundBeacon.proximityUUID.UUIDString;
            NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
            NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
            
            // Get proximity
            if (foundBeacon.proximity == CLProximityImmediate) { // Tapping the the beacon
                //_signalIndicator.image = [PlacesKit imageOfFull];
                if (![linkURL isEqualToString:@""]) {
                    // Initiate segue only when linkURL is not empty
                    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
                }
            } else if (foundBeacon.proximity == CLProximityNear) { // Near the beacon (strong signal)
                //_signalIndicator.image = [PlacesKit imageOfFull];
            } else if (foundBeacon.proximity == CLProximityFar) { // (med/weak signal)
                //_signalIndicator.image = [PlacesKit imageOfHalf];
            } else if (foundBeacon.proximity == CLProximityUnknown) { // (weak/v. weak signal)
                //_signalIndicator.image = [PlacesKit imageOfLow];
            }
            
            // Call the function to automatically set the text
            [self setTableValue:major minor:minor];
        }
    } else {
        // Still in region but no good lock on to beacon
        /*_inferredLocation.text = @"Weak Signal";
         _signalIndicator.image = [PlacesKit imageOfNone];
         [UIView transitionWithView:_bgImg duration:0.4f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{_bgImg.image = [UIImage imageNamed:@"SSTGeneric"];} completion:nil];
         _inferredInfo.text = @"The Bluetooth signal is too weak to determine your accurate position. You might not be in a good iBeacon coverage zone. Please walk around SST to double check your connection.";*/
    }
}

-(void)setTableValue:(NSString *)major minor:(NSString *)minor
{
    locationString = [[NSString alloc] init];
    
    NSLog(@"Major:%@, Minor: %@", major, minor); // Echo major/minor combo on console
    
    // Admin block
    if ([major isEqual:@"1"]) {
        if ([minor isEqual:@"1"]) {
            
        }
        else
            //locationString=@"Weak Signal";
            goto unimplemented;
    }
    // Block B
    else if ([major isEqual:@"2"]) {
        if ([minor isEqual:@"2"]){

        }
        else {
            goto unimplemented;
        }
    }
    // Block C
    else if ([major isEqual:@"3"]) {
        if ([minor isEqual:@"1"]) {

        }
        else if ([minor isEqual:@"2"]) {
            // ID: 1 (INC)
#warning If its inc
        }
        else if ([minor isEqual:@"3"]) {
            // ID: 2 (Betalabs)
#warning If its Betalabs
        }
        else if ([minor isEqual:@"4"]) {
            
        }
        else {
            goto unimplemented;
        }
    }
    // Sports complex
    else if ([major isEqual:@"4"]) {
        // ID: 3 (Sports Complex)
#warning If its Sports Complex
    }
    else
    {
    unimplemented:
        NSLog(@"Unimplemented beacon with major,minor: %@, %@", major, minor);
    }
}

#pragma mark - Bluetooth Controller Delegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if ([central state] == CBCentralManagerStatePoweredOn) {
        //bluetoothEnabled = YES
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        //bluetoothEnabled = NO;
        [self performSegueWithIdentifier:@"NoBluetoothSegue" sender:self];
    }
}

- (void)startBluetoothStatusMonitoring {
    self.bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:@{CBCentralManagerOptionShowPowerAlertKey: @(NO)}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
