//
//  ViewController.h
//  MapAssignment
//
//  Created by Apurva Kumari on 9/24/17.
//  Copyright © 2017 Apurva Kumari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import "RouteViewController.h"

@interface HomeViewController : UIViewController
@property CLLocationCoordinate2D sourceCoords;
@property CLLocationCoordinate2D destinationCoords;
@property MKMapItem *sorcemapItem;
@property MKMapItem *destinationmapItem;


@property (weak, nonatomic) IBOutlet UITextField *fromstreet;
@property (weak, nonatomic) IBOutlet UITextField *fromcity;
@property (weak, nonatomic) IBOutlet UITextField *fromstate;
@property (weak, nonatomic) IBOutlet UITextField *fromzip;

@property (weak, nonatomic) IBOutlet UITextField *toStreet;
@property (weak, nonatomic) IBOutlet UITextField *tocity;
@property (weak, nonatomic) IBOutlet UITextField *tostate;
@property (weak, nonatomic) IBOutlet UITextField *tozip;
- (IBAction)getMap:(id)sender;
- (IBAction)getRoute:(id)sender;


@end

