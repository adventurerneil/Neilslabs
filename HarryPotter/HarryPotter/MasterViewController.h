//
//  MasterViewController.h
//  HarryPotter
//
//  Created by Neil Dimuccio on 10/31/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (copy, nonatomic) NSArray *characters;

@end
