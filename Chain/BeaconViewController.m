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
}

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    // No signal
    NSLog(@"didExitRegion Triggered! Stopping ranging services...");
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    //_signalIndicator.image = [PlacesKit imageOfNone];
    //_inferredLocation.text = @"No Signal";
    //_inferredInfo.text = @"The app detected no Bluetooth signals from the iBeacons. You might not be in the beacon coverage zone. Please walk around SST to double check your connection.";
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
        }
            break;
        case CLRegionStateOutside: {
            NSLog(@"Outside region");
            // No beacons are in range
            //_signalIndicator.image = [PlacesKit imageOfNone];
            //_nferredLocation.text = @"No Signal";
            //_inferredInfo.text = @"The app detected no Bluetooth signals from the iBeacons. You might not be in the beacon coverage zone. Please walk around SST to double check your connection.";
        }
            break;
        case CLRegionStateUnknown:
            NSLog(@"State unknown");
            break;
        default:
            // stop ranging beacons, etc
            NSLog(@"Region unknown");
            //[self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
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
    
    // Admin block
    if ([major isEqual:@"1"]) {
        if ([minor isEqual:@"1"]) {
            locationString = [locationString stringByAppendingString:@"SST Wall"];
            linkURL = @"http://www.sst.edu.sg";
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
            
        }
        else if ([minor isEqual:@"3"]) {
            
        }
        else if ([minor isEqual:@"4"]) {
            
        }
        else {
            //locationString=@"Polling...";
            goto unimplemented;
        }
    }
    // Sports complex
    else if ([major isEqual:@"4"]) {
        
    }
    else
    {
    unimplemented:
        NSLog(@"Not implemented beacon with major,minor: %@, %@", major, minor);
    }
    
    // Finally set the text
    //_inferredLocation.text = locationString;
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
