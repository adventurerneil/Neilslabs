//
//  SecondViewController.h
//  BoulderUU
//
//  Created by Neil Dimuccio on 10/17/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
- (IBAction)submitQuestion:(UIButton *)sender;

@end
