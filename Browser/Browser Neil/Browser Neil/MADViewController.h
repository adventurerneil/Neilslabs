//
//  MADViewController.h
//  Browser Neil
//
//  Created by Neil Dimuccio on 9/24/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController<UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;

@end
