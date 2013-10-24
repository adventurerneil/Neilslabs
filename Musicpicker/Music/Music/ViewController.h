//
//  ViewController.h
//  Music
//
//  Created by Neil Dimuccio on 10/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *decade;

@end
