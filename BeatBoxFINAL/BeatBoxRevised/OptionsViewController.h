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

@class OptionsViewController;

@protocol OptionsViewControllerDelegate <NSObject>

- (void)addItemViewController:(OptionsViewController *)controller didFinishEnteringItem:(NSString *)item;
@end


float optionsVolume;
float initalVolume;

@interface OptionsViewController : UIViewController{
//@property (nonatomic, weak) id<OptionsViewControllerDelegate> delegate;
    id delegate;
    //IBOutlet UITextField *sometext;
}
//Labels for sliders:
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayLabel;
@property (weak, nonatomic) IBOutlet UILabel *panningLabel;
//Slider values:
@property (strong, nonatomic) IBOutlet UISlider *optionsVolumeValue;
@property (strong, nonatomic) IBOutlet UISlider *optionsRateValue;
@property (weak, nonatomic) IBOutlet UISlider *optionsPanningSlider;

@property (nonatomic) BOOL volumeChanged;
@property (nonatomic) BOOL replayChanged;
@property (nonatomic) BOOL panningChanged;

//Values changed from Options screen:
@property (nonatomic) float passedinVolume;
@property (nonatomic) float passedinRate;
@property (nonatomic) float passedinPanning;

//Floats for current values (tied to sliders' labels):
@property (nonatomic) float volumeValueFromOptions;
@property (nonatomic) float replayValueFromOptions;
@property (nonatomic) float panningValueFromOptions;

//Set current values:
@property (nonatomic) float currentReplaySpeed;
@property (nonatomic) float currentVolume;
@property (nonatomic) float currentPan;

//Set initial values:
@property (nonatomic) float initialReplaySpeed;
@property (nonatomic) float initialVolume;
@property (nonatomic) float initialPan;


//Delegate property, must synthesize in .m
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