//
//  ViewController.h
//  favorites
//
//  Created by Neil Dimuccio on 10/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavData.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bookLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic)FavData *user;

@end
