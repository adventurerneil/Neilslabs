//
//  MADViewController.h
//  HelloWorld2Neil
//
//  Created by Neil Dimuccio on 9/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *messageText;
- (IBAction)buttonPressed:(UIButton *)sender;
- (IBAction)goodbyePressed:(UIButton *)sender;

@end
