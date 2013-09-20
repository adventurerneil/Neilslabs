//
//  MADViewController.m
//  sportImage
//
//  Created by Neil Dimuccio on 9/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    if (sender.tag == 1)
    { _sportImage.image=[UIImage imageNamed:@"rockies_logo"];
        NSString *message = [[NSString alloc] initWithFormat: @"Let's go to Coors Stadium, %@!", _nameField.text];
        _messageLabel.text=message;
    }

    if (sender.tag == 2)
    { _sportImage.image=[UIImage imageNamed:@"broncos_logo"];
        NSString *message = [[NSString alloc] initWithFormat: @"The Broncos win if you don't watch them play, %@.", _nameField.text];
        _messageLabel.text=message;
    }
}
- (IBAction)textFieldDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];

}
@end
