//
//  Scene2ViewController.m
//  favorites
//
//  Created by Neil Dimuccio on 10/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "Scene2ViewController.h"

@interface Scene2ViewController ()

@end

@implementation Scene2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userInfo=[[FavData alloc] init];
    _userBook.delegate=self;
    _userAuthor.delegate=self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender{
    if ([segue.identifier isEqualToString:@"donezoes"]) {
        _userInfo.favBook=_userBook.text;
        _userInfo.favAuthor=_userAuthor.text;
        //creating an object for our destinationViewController so we can send the data back
        ViewController *ViewController=[segue destinationViewController];
        ViewController.user.favBook=_userInfo.favBook;
        ViewController.user.favAuthor=_userInfo.favAuthor;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
