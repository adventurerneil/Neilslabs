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
AVAudioPlayer *audioPlayerLoop;
BOOL isFirstTime;
BOOL loopIsPlaying;


@interface PlayViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate> //OptionsViewControllerDelegate



@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatButton;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
//Values changed from Options screen:
@property (nonatomic) float optionsVolume;
@property (nonatomic) float replay;
@property (nonatomic) float optionsPanning;
//Set initial values:
@property (nonatomic) float initialReplaySpeed;
@property (nonatomic) float initialVolume;
@property (nonatomic) float initialPan;
//See if initial values changed:
@property (nonatomic) BOOL volumeChanged;
@property (nonatomic) BOOL replayChanged;
@property (nonatomic) BOOL panningChanged;
@property (nonatomic) BOOL volumeChanged1;
@property (nonatomic) BOOL replayChanged1;
@property (nonatomic) BOOL panningChanged1;

//Set current values:
@property (nonatomic) float currentReplaySpeed;
@property (nonatomic) float currentVolume;
@property (nonatomic) float currentPan;

- (IBAction)button1Pressed:(UIButton *)sender;
- (IBAction)button2Pressed:(UIButton *)sender;
- (IBAction)button3Pressed:(UIButton *)sender;
- (IBAction)button4Pressed:(UIButton *)sender;

- (IBAction)playPressed:(UIButton *)sender;
- (IBAction)repeatPressed:(UIButton *)sender;
- (IBAction)stopPressed:(UIButton *)sender;
- (IBAction)recordPressed:(UIButton *)sender;



@end
