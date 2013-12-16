//
//  Archive.h
//  Task
//
//  Created by Neil Dimuccio on 12/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Archive : NSObject<NSCoding, NSCopying>

@property(copy, nonatomic)NSString *taskone;
@property(copy, nonatomic)NSString *tasktwo;
@property(copy, nonatomic)NSString *taskthree;
@property(copy, nonatomic)NSString *taskfour;

@end
