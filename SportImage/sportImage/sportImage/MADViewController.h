//
//  MADViewController.h
//  sportImage
//
//  Created by Neil Dimuccio on 9/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *sportImage;
- (IBAction)buttonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;

@end
