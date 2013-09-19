//
//  MADViewController.h
//  Hello World
//
//  Created by Neil Dimuccio on 8/29/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//
// Icon photo credit: 

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)buttonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageText;

@end
