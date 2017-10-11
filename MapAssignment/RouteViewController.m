//
//  RouteViewController.m
//  MapAssignment
//
//  Created by Apurva Kumari on 9/25/17.
//  Copyright © 2017 Apurva Kumari. All rights reserved.
//


#import "RouteViewController.h"

@interface RouteViewController ()

@end

@implementation RouteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _routeMap.delegate = self;

    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = _source.placemark.coordinate;
    [self.routeMap addAnnotation:point];
    
    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
    point2.coordinate = _destination.placemark.coordinate;
    [self.routeMap addAnnotation:point2];
    
    
    CLLocation *locA = _source.placemark.location;
    CLLocation *locB = _destination.placemark.location;
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, distance * 3, distance * 3);
    [self.routeMap setRegion:[self.routeMap regionThatFits:region] animated:YES];
    
    // get route
    [self getDirections];
    
}

- (void)getDirections
{
    MKDirectionsRequest *request =[[MKDirectionsRequest alloc] init];
    
    request.source = _source;
    request.destination = _destination;
    
    request.requestsAlternateRoutes = NO;
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
             printf("Can't Get directions");
         } else {
 
             [self showRoute:response];
             printf("Showing directions");
         }
     }];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_routeMap
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (IBAction)backToHome:(id)sender{
    printf("\n Baclk Button is pressed");
    [self performSegueWithIdentifier:@"HomeViewSegue" sender:self];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
