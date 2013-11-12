//
//  PlayViewController.h
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "OptionsViewController.h"


AVAudioPlayer *audioPlayer1;
AVAudioPlayer *audioPlayer2;
AVAudioPlayer *audioPlayer3;
AVAudioPlayer *audioPlayer4;
BOOL isFirstTime;


@interface PlayViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITextFieldDelegate> 



@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatButton;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (nonatomic) float optionsVolume;
@property (nonatomic) float replay;
@property (nonatomic) float initialVolume;
@property (nonatomic) BOOL volumeChanged;
@property (nonatomic) BOOL replayChanged;

- (IBAction)button1Pressed:(UIButton *)sender;
- (IBAction)button2Pressed:(UIButton *)sender;
- (IBAction)button3Pressed:(UIButton *)sender;
- (IBAction)button4Pressed:(UIButton *)sender;

- (IBAction)playPressed:(UIButton *)sender;
- (IBAction)repeatPressed:(UIButton *)sender;
- (IBAction)stopPressed:(UIButton *)sender;
- (IBAction)recordPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *VolumeOutput;
@property (strong, nonatomic) IBOutlet UILabel *ReplayOutput;
- (IBAction)volumeEntry:(UITextField *)sender;
- (IBAction)replayEntry:(UITextField *)sender;
@property (strong, nonatomic) IBOutlet UITextField *volumeEntry;

@end