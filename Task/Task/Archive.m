//
//  Archive.m
//  Task
//
//  Created by Neil Dimuccio on 12/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "Archive.h"

@implementation Archive

#define kTask1key @"Task1"
#define kTask2key @"Task2"
#define kTask3key @"Task3"
#define kTask4key @"Task4"

//NSCoder method to encode objects into an archive
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode the 4 strings into the archive
    [aCoder encodeObject:_taskone forKey:kTask1key];
    [aCoder encodeObject:_tasktwo forKey:kTask2key];
    [aCoder encodeObject:_taskthree forKey:kTask3key];
    [aCoder encodeObject:_taskfour forKey:kTask4key];
}

//NSCoder method to decode from archive
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        //decode 4 strings from archive
        _taskone=[aDecoder decodeObjectForKey:kTask1key];
        _tasktwo=[aDecoder decodeObjectForKey:kTask2key];
        _taskthree=[aDecoder decodeObjectForKey:kTask3key];
        _taskfour=[aDecoder decodeObjectForKey:kTask4key];
    }
    return self;
}

//NSCopy method to copy objects
-(id) copyWithZone:(NSZone *)zone {
    //create a new object and copy 4 strings into it
    Archive *copy = [[[self class] allocWithZone:zone]init];
    copy.taskone=[self.taskone copyWithZone:zone];
    copy.tasktwo=[self.tasktwo copyWithZone:zone];
    copy.taskthree=[self.taskthree copyWithZone:zone];
    copy.taskfour=[self.taskfour copyWithZone:zone];
    return copy;
}

@end
