//
//  Scene2ViewController.h
//  favorites
//
//  Created by Neil Dimuccio on 10/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavData.h"
#import "ViewController.h"

@interface Scene2ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userBook;
@property (weak, nonatomic) IBOutlet UITextField *userAuthor;
@property (strong, nonatomic)FavData *userInfo;

@end    
