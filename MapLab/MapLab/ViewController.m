//
//  ViewController.m
//  MapLab
//
//  Created by Neil Dimuccio on 11/21/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"

Annotation *annotation;

@interface ViewController ()

@end

@implementation ViewController{
    CLLocationManager *locationManager;
}

- (void)viewDidLoad
{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    _mapView.delegate=self;
    _mapView.mapType=MKMapTypeHybrid; //hybrid with map and satellite
	[super viewDidLoad];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    _latitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", manager.location.coordinate.latitude]; //assign the latitude as a string to the text field
    _longitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", manager.location.coordinate.longitude]; //assign the longitude as a string to the text field
    _altitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", manager.location.altitude]; //assign the accuracy as a string to the text field
    _accuracyLabel.text=[[NSString alloc] initWithFormat:@"%f", manager.location.horizontalAccuracy]; //assign the accuracy as a string to the text field
    MKCoordinateSpan span;
    span.latitudeDelta=.05; //the amount of north-to-south distance (measured in degrees) to display on the map
    span.longitudeDelta=.05; //the amount of east-to-west distance (measured in degrees) to display for the map region.
    MKCoordinateRegion region; //region of the map to be displayed
    region.center= manager.location.coordinate; //sets the center of the region to be the newLocation
    region.span=span; //sets the horizontal and vertical span of the map to display
    [_mapView setRegion:region animated:YES]; //animates changing the currently visible region
    
    //display annotation
    if(annotation){
        [annotation moveAnnotation:manager.location.coordinate]; //moves the annotation if it already exists
            }
    else { //creates an annotation if one does not exist
        annotation=[[Annotation alloc]
        initWithCoordinate:manager.location.coordinate]; //creates new annotation
        [_mapView addAnnotation:annotation]; //adds the annotation to the mapview
    }
}

//called when a location cannot be determined
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorType;
    if (error.code == kCLErrorDenied) {
        errorType=@"Access Denied";
    } else errorType=@"Error";
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
                                                  message:errorType
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
