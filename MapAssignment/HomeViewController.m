//
//  ViewController.m
//  MapAssignment
//
//  Created by Apurva Kumari on 9/24/17.
//  Copyright © 2017 Apurva Kumari. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    printf("\n Home View has loaded");
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)getMap:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSString *fromaddressString =
    [NSString stringWithFormat:@"%@ %@ %@ %@",_fromstreet.text,_fromcity.text,_fromstate.text,_fromzip.text];
    
    NSString *toaddressString =
    [NSString stringWithFormat:@"%@ %@ %@ %@",_toStreet.text,_tocity.text,_tostate.text,_tozip.text];
    
    [geocoder geocodeAddressString:fromaddressString completionHandler:^(NSArray *placemarks,NSError *error) {
         
         if (error) {
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         
         if (placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = placemarks[0];
             
             CLLocation *location = placemark.location;
             _sourceCoords = location.coordinate;
             
             //[self showMap];
         }
     }];
    
    CLGeocoder *geocoder2 = [[CLGeocoder alloc] init];
    
    [geocoder2 geocodeAddressString:toaddressString completionHandler:^(NSArray *placemarks,NSError *error) {
        
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        
        if (placemarks && placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            
            CLLocation *location = placemark.location;
            _destinationCoords = location.coordinate;
            
            [self showMap];
        }
    }];
}

-(void)showMap
{
    NSDictionary *fromaddress = @{
                              (NSString *)CNPostalAddressStreetKey: _fromstreet.text,
                              (NSString *)CNPostalAddressCityKey: _fromcity.text,
                              (NSString *)CNPostalAddressStateKey: _fromstate.text,
                              (NSString *)CNPostalAddressPostalCodeKey: _fromzip.text
                              };
    NSDictionary *toaddress = @{
                              (NSString *)CNPostalAddressStreetKey: _toStreet.text,
                              (NSString *)CNPostalAddressCityKey: _tocity.text,
                              (NSString *)CNPostalAddressStateKey: _tostate.text,
                              (NSString *)CNPostalAddressPostalCodeKey: _tozip.text
                              };
    
    MKPlacemark *sourceplace = [[MKPlacemark alloc] initWithCoordinate:_sourceCoords addressDictionary:fromaddress];
    MKPlacemark *destinationplace = [[MKPlacemark alloc] initWithCoordinate:_destinationCoords addressDictionary:toaddress];
    
    _sorcemapItem =[[MKMapItem alloc]initWithPlacemark:sourceplace];
 //   [_sorcemapItem setName:_fromstreet.text + @"," + fromcity.text + @"," _fromstate.text];
    
    _destinationmapItem =[[MKMapItem alloc]initWithPlacemark:destinationplace];
    [_destinationmapItem setName:_toStreet.text];
    
    
    [_destinationmapItem openInMapsWithLaunchOptions:nil];
}

- (IBAction)getRoute:(id)sender {
    
    printf("\n Route Button is pressed");
   [self performSegueWithIdentifier:@"MapViewSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"MapViewSegue"])
    {
        // Get reference to the destination view controller
       RouteViewController *routeController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [routeController setSource:_sorcemapItem];
        [routeController setDestination:_destinationmapItem];
        
    }
}

@end
