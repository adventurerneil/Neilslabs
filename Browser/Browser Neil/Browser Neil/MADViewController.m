//
//  MADViewController.m
//  Browser Neil
//
//  Created by Neil Dimuccio on 9/24/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//  rememberToAlwaysUseCamelCase!!! //

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView.delegate=self;
    [self loadWebPageWithString:@"http://neildimuccio.com/wp"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading web page"
                                                    message:[error localizedDescription]
                                                    delegate:self
                                            cancelButtonTitle:@"Go back"
                                            otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Pick your poison:"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:@"DESTROY"
                                                  otherButtonTitles:@"ATLAS", @"TAM", @"CU", nil];
    [actionSheet showFromToolbar:_toolbar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0) {
        [self loadWebPageWithString:@"http://zombo.com"];
    }
    else if (buttonIndex==1) {
        [self loadWebPageWithString:@"http://atlas.colorado.edu"];
    }
    else if (buttonIndex==2) {
        [self loadWebPageWithString:@"http://tam.colorado.edu"];
    }
    else if (buttonIndex==3) {
        [self loadWebPageWithString:@"http://www.colorado.edu"];
    }
}

@end
