//
//  Play2ViewController.m
//  BeatBoxRevised
//
//  Created by Neil DiMuccio on 11/11/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "Play2ViewController.h"

@interface Play2ViewController (){
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    
}

@end

@implementation Play2ViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Button1Pressed:(UIButton *)sender {
    [_button1 setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Quack" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
        audioPlayer1.volume = _initialVolume;
    //}
    //else audioPlayer1.volume = _optionsVolume;
    [audioPlayer1 play];
}

- (IBAction)Button2Pressed:(UIButton *)sender {
    [_button2 setBackgroundImage:[self imageWithColor:[UIColor cyanColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"newbip" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
        audioPlayer2.volume = _initialVolume;
    //}
    //else audioPlayer2.volume = _optionsVolume;
    [audioPlayer2 play];
}

- (IBAction)Button3Pressed:(UIButton *)sender {
    [_button3 setBackgroundImage:[self imageWithColor:[UIColor magentaColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Sosumi" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
        audioPlayer3.volume = _initialVolume;
    //}
    //else audioPlayer3.volume = _optionsVolume;
    [audioPlayer3 play];
}

- (IBAction)Button4Pressed:(UIButton *)sender {
    [_button4 setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Indigo" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
        audioPlayer4.volume = _initialVolume;
    //}
    //else audioPlayer4.volume = _optionsVolume;
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

- (IBAction)Button5Pressed:(UIButton *)sender {
    [_button5 setBackgroundImage:[self imageWithColor:[UIColor purpleColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Clink-Klank" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer5 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
    audioPlayer5.volume = _initialVolume;
    //}
    //else audioPlayer4.volume = _optionsVolume;
    [audioPlayer5 play];
}

- (IBAction)Button6Pressed:(UIButton *)sender {
    [_button6 setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"ChuToy" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer6 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
    audioPlayer6.volume = _initialVolume;
    //}
    //else audioPlayer4.volume = _optionsVolume;
    [audioPlayer6 play];
}

- (IBAction)Button7Pressed:(UIButton *)sender {
    [_button7 setBackgroundImage:[self imageWithColor:[UIColor brownColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Pong2003" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer7 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
    audioPlayer7.volume = _initialVolume;
    //}
    //else audioPlayer4.volume = _optionsVolume;
    [audioPlayer7 play];
}

- (IBAction)Button8Pressed:(UIButton *)sender {
    [_button8 setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Boing" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer8 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    //if (_volumeChanged == NO) {
    audioPlayer8.volume = _initialVolume;
    //}
    //else audioPlayer4.volume = _optionsVolume;
    [audioPlayer8 play];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if...
    //PlayViewController *ViewController = segue.destinationViewController;
    
    //ViewController.delegate = self;
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft   | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

    
@end
