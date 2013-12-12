//
//  OptionsViewController.h
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"
#import "Play2ViewController.h"

@protocol OptionsViewControllerDelegate <NSObject>
//-(void) done:(NSString *) someText;

@end

float optionsVolume;
float initalVolume;

@interface OptionsViewController : UIViewController{
//@property (nonatomic, weak) id<OptionsViewControllerDelegate> delegate;
    id delegate;
    //IBOutlet UITextField *sometext;
}
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayLabel;
@property (weak, nonatomic) IBOutlet UILabel *panningLabel;

@property (strong, nonatomic) IBOutlet UISlider *optionsVolumeValue;
@property (strong, nonatomic) IBOutlet UISlider *optionsRateValue;
@property (weak, nonatomic) IBOutlet UISlider *optionsPanningSlider;


@property (strong, nonatomic) NSNumber *volume;
@property (strong, nonatomic) NSNumber *rate;
@property (strong, nonatomic) NSNumber *panning;

@property (nonatomic, assign) id <OptionsViewControllerDelegate> delegate;

@property (weak, nonatomic) UIViewController *returnViewController;



- (IBAction)volumeSlider:(UISlider *)sender;
- (IBAction)replaySlider:(UISlider *)sender;
- (IBAction)panningSlider:(UISlider *)sender;


//May not be necessary:
//- (IBAction) handleCloseButton:(id)sender;


@end

/*
@protocol OptionsViewControllerDelegate <NSObject>

- (void)OptionsViewController:(OptionsViewController*)viewController
didChooseValue:(CGFloat)value;

@end
*/