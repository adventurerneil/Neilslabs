//
//  ViewController.m
//  Task
//
//  Created by Neil Dimuccio on 12/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"
#import "Archive.h"


@interface ViewController ()

@end

@implementation ViewController

#define kFilename @"archive" //archive file name
#define kDataKey @"Data" //key value for coding

-(NSString *)getMyData{
    //locates document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [self getMyData];
    
    //check to see if file exists:
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //load the contents of the file into an array
        //NSArray *dataArray=[[NSArray alloc] initWithContentsOfFile:filePath];
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self getMyData]];
        //create an instance to decode the data
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //read the objects from the unarchiver
        Archive *taskArchive = [unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding]; //tell the unarchiver we're finished
        
        //copy values from the ordered array into the text fields
        _task1.text=taskArchive.taskone;
        _task2.text=taskArchive.tasktwo;
        _task3.text=taskArchive.taskthree;
        _task4.text=taskArchive.taskfour;
    }
    UIApplication *app=[UIApplication sharedApplication]; //application instance
    //subscribe to the UIApplicationWillResignActiveNotification notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
}

-(void)applicationWillResignActive:(NSNotification *)notification{
    Archive *taskArchive=[[Archive alloc]init];
    taskArchive.taskone=_task1.text;
    taskArchive.tasktwo=_task2.text;
    taskArchive.taskthree=_task3.text;
    taskArchive.taskfour=_task4.text;
    //create an instance to hold the encoded data
    NSMutableData *data=[[NSMutableData alloc]init];
    //create instance to archive objects
    NSKeyedArchiver *archiver=[[NSKeyedArchiver
                                alloc]initForWritingWithMutableData:data];
    //archive objects
    [archiver encodeObject:taskArchive forKey:kDataKey];
    [archiver finishEncoding]; //tell the archiver we're finished
    //write the contents of the array to our plist file
    [data writeToFile:[self getMyData] atomically:YES];
    
    
    //    NSString *filePath=[self getMyData];
//    //create a mutable array and add the data from the text fields to it
//    NSMutableArray *array=[[NSMutableArray alloc] init];
//    [array addObject:_task1.text];
//    [array addObject:_task2.text];
//    [array addObject:_task3.text];
//    [array addObject:_task4.text];
//    //write the contents of the array to our plist file:
//    [array writeToFile:filePath atomically:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
