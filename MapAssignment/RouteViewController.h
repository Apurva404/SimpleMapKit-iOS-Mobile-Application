//
//  RouteViewController.h
//  MapAssignment
//
//  Created by Apurva Kumari on 9/25/17.
//  Copyright © 2017 Apurva Kumari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteViewController : UIViewController
<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *routeMap;
@property (strong, nonatomic) MKMapItem *source;
@property (strong, nonatomic) MKMapItem *destination;
- (IBAction)backToHome:(id)sender;
@end
