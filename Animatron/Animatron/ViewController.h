//
//  ViewController.h
//  Animatron
//
//  Created by Neil Dimuccio on 11/14/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderMoved:(UISlider *)sender;

@end
