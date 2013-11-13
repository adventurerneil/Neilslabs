//
//  ViewController.m
//  favorites
//
//  Created by Neil Dimuccio on 10/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _user=[[FavData alloc]init]; //allocates memory and initializes the user object
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returned:(UIStoryboardSegue *) segue{
    _bookLabel.text=_user.favBook;
    _authorLabel.text=_user.favAuthor;
}

-(void)viewWillAppear:(BOOL)animated{
    _bookLabel.text=_user.favBook;
    _authorLabel.text=_user.favAuthor;
}


@end
