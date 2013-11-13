//
//  DetailViewController.h
//  Countries
//
//  Created by Neil Dimuccio on 10/24/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryViewController.h"

@interface DetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *countryList;
@property(strong, nonatomic)NSString *countryName;

@end
