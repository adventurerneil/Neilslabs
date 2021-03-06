//
//  Play2ViewController.h
//  BeatBoxRevised
//
//  Created by Neil DiMuccio on 11/11/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayViewController.h"

AVAudioPlayer *audioPlayer1;
AVAudioPlayer *audioPlayer2;
AVAudioPlayer *audioPlayer3;
AVAudioPlayer *audioPlayer4;
AVAudioPlayer *audioPlayer5;
AVAudioPlayer *audioPlayer6;
AVAudioPlayer *audioPlayer7;
AVAudioPlayer *audioPlayer8;

BOOL isFirstTime;
BOOL loopIsPlaying;

@interface Play2ViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatButton;


//Values changed from Options screen:
@property (nonatomic) float passedinVolume;
@property (nonatomic) float passedinRate;
@property (nonatomic) float passedinPanning;
//Set initial values:
@property (nonatomic) float initialReplaySpeed;
@property (nonatomic) float initialVolume;
@property (nonatomic) float initialPan;
//See if initial values changed:
@property (nonatomic) BOOL volumeChanged;
@property (nonatomic) BOOL replayChanged;
@property (nonatomic) BOOL panningChanged;
//Set current values:
@property (nonatomic) float currentReplaySpeed;
@property (nonatomic) float currentVolume;
@property (nonatomic) float currentPan;
//Plist read ins:
@property (nonatomic) float volFloat;


@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;

- (IBAction)Button1Pressed:(UIButton *)sender;
- (IBAction)Button2Pressed:(UIButton *)sender;
- (IBAction)Button3Pressed:(UIButton *)sender;
- (IBAction)Button4Pressed:(UIButton *)sender;
- (IBAction)playPressed:(UIButton *)sender;
- (IBAction)repeatPressed:(UIButton *)sender;
- (IBAction)stopPressed:(UIButton *)sender;
- (IBAction)recordPressed:(UIButton *)sender;
- (IBAction)Button5Pressed:(UIButton *)sender;
- (IBAction)Button6Pressed:(UIButton *)sender;
- (IBAction)Button7Pressed:(UIButton *)sender;
- (IBAction)Button8Pressed:(UIButton *)sender;



@end
