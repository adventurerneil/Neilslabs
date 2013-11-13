//
//  FavData.h
//  favorites
//
//  Created by Neil Dimuccio on 10/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavData : NSObject

@property(copy, nonatomic) NSString *favBook;      //USE copy for NSString, NSArray
@property(copy, nonatomic) NSString *favAuthor;    //USE copy for NSString, NSArray

@end
