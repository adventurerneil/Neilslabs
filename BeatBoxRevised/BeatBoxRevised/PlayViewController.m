//
//  PlayViewController.m
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "PlayViewController.h"
#import "OptionsViewController.h"

/*
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
*/

@interface PlayViewController (){
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}

@end

@implementation PlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	isFirstTime = YES;
    // Disable Stop/Play button when application launches
    [_stopButton setEnabled:NO];
    [_playButton setEnabled:NO];
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"Sample.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    // Set rate for playback
    player.enableRate=YES;
    
    // Set initial Volume
    _initialVolume = 1.0f;
    
    // See if anything's working or not:
    [_VolumeOutput setText:[NSString stringWithFormat:@"Vol %f", _optionsVolume]];
    [_ReplayOutput setText:[NSString stringWithFormat:@"Rep %f", _replay]];
    self.volumeEntry.delegate = self;


}



- (IBAction)button1Pressed:(UIButton *)sender {
    [_button1 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Volume" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer1.volume = _initialVolume;
    }
    else audioPlayer1.volume = _optionsVolume;
    [audioPlayer1 play];
}

- (IBAction)button2Pressed:(UIButton *)sender {
    [_button2 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Select" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer2.volume = _initialVolume;
    }
    else audioPlayer2.volume = _optionsVolume;
    [audioPlayer2 play];
}

- (IBAction)button3Pressed:(UIButton *)sender {
    [_button3 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"BubbleAppear" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer3.volume = _initialVolume;
    }
    else audioPlayer3.volume = _optionsVolume;
    [audioPlayer3 play];
}

- (IBAction)button4Pressed:(UIButton *)sender {
    [_button4 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"WrapBoundary_Alternate" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer4.volume = _initialVolume;
    }
    else audioPlayer4.volume = _optionsVolume;
    [audioPlayer4 play];
}

- (IBAction)playPressed:(UIButton *)sender {
    [_playButton setEnabled:YES];
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        
        player.rate=2.0f;
        [player setDelegate:self];
        [player play];
    }
}

- (IBAction)repeatPressed:(UIButton *)sender {
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        player.rate=2.0f;
        [player setDelegate:self];
        [player play];
        
    }
    if (isFirstTime){
        player.numberOfLoops = -1;
        [_repeatButton setTitle:@"Repeat on" forState:UIControlStateNormal];
        isFirstTime = NO;
        [_playButton setEnabled:NO];
    } else {
        [player stop];
        [_repeatButton setTitle:@"Repeat off" forState:UIControlStateNormal];
        isFirstTime = YES;
        [_playButton setEnabled:YES];
    }
}

- (IBAction)stopPressed:(UIButton *)sender {
    [recorder stop];
    [player stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)recordPressed:(UIButton *)sender {
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        [_recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [recorder pause];
        [_recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [_stopButton setEnabled:YES];
    [_playButton setEnabled:NO];
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [_recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    
    //[_stopButton setEnabled:NO];
    [_playButton setEnabled:YES];
}

- (IBAction)unwindToPlayViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if...
    //OptionsViewController *ViewController = segue.destinationViewController;
    //ViewController.delegate = self;
}

-(void)done:(NSString *)name {
    [self dismissViewControllerAnimated:YES completion:nil];
    _VolumeOutput.text=name;
}

- (IBAction)volumeEntry:(UITextField *)sender {
}

- (IBAction)replayEntry:(UITextField *)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey, boss!!" message:self.volumeEntry.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
    //NSString *string = _volumeEntry;
    //int value = [string intValue];

    [self.volumeEntry resignFirstResponder];
    return YES;
    
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft   | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)viewWillAppear:(BOOL)animated {
//Set things here for each time view shows up - viewdidload is on run only.
}

@end
