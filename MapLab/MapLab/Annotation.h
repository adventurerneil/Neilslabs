//
//  Annotation.h
//  MapLab
//
//  Created by Neil Dimuccio on 11/21/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coor;
-(void) moveAnnotation:(CLLocationCoordinate2D)newCoordinate;

@end
