//
//  Play2ViewController.m
//  BeatBoxRevised
//
//  Created by Neil DiMuccio on 11/11/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "Play2ViewController.h"
// For plist read in
#define kFilename @"data.plist"

@interface Play2ViewController (){
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    AVAudioPlayer *audioPlayerLoop;
    
}

@end

@implementation Play2ViewController
NSTimer *update;

//Passed in values:
@synthesize passedinPanning;
@synthesize passedinRate;
@synthesize passedinVolume;

@synthesize currentVolume;
@synthesize currentReplaySpeed;
@synthesize currentPan;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    isFirstTime = YES;
    loopIsPlaying = NO;
    // Disable Stop/Play button when application launches
    //[_stopButton setEnabled:NO];
    //[_playButton setEnabled:NO];
    
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
    [recordSetting setValue:[NSNumber numberWithFloat: 128000] forKey:AVEncoderBitRateKey];
    
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    // Set rate for playback
    player.enableRate=YES;
    audioPlayerLoop.enableRate=YES;
    
    _initialReplaySpeed = 1.0f;
    
    // Set initial Volume
    _initialVolume = 0.8f;
    
    // Set initial Pan
    _initialPan = 0.0f;
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updiz) userInfo:nil repeats:YES];
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
    if (_volumeChanged == NO) {
        audioPlayer1.volume = _initialVolume;
    }
    else audioPlayer1.volume = currentVolume;
    [audioPlayer1 play];
}

- (IBAction)Button2Pressed:(UIButton *)sender {
    [_button2 setBackgroundImage:[self imageWithColor:[UIColor cyanColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"newbip" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer2.volume = _initialVolume;
    }
    else audioPlayer2.volume = currentVolume;
    [audioPlayer2 play];
}

- (IBAction)Button3Pressed:(UIButton *)sender {
    [_button3 setBackgroundImage:[self imageWithColor:[UIColor magentaColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Sosumi" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer3.volume = _initialVolume;
    }
    else audioPlayer3.volume = currentVolume;
    [audioPlayer3 play];
}

- (IBAction)Button4Pressed:(UIButton *)sender {
    [_button4 setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Indigo" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer4.volume = _initialVolume;
    }
    else audioPlayer4.volume = currentVolume;
    [audioPlayer4 play];
}

- (IBAction)playPressed:(UIButton *)sender {
    [_playButton setEnabled:YES];
    if (!recorder.recording){
        if (_replayChanged == NO) {
            player.rate=_initialReplaySpeed;
            NSLog(@"Play replay speed if: %f", player.rate);}
        else if (_replayChanged == YES) {
            player.rate=currentReplaySpeed;
            NSLog(@"Play replay speed else 2: %f", currentReplaySpeed);}
        
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        
        
        [player setDelegate:self];
        [player play];
    }
}

- (IBAction)repeatPressed:(UIButton *)sender {
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        if (_replayChanged) {
        player.rate=currentReplaySpeed;
        }
        else currentReplaySpeed = _initialReplaySpeed;
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
    [_playButton setEnabled:YES];
    [recorder stop];
    [player stop];
    [audioPlayerLoop stop];
    loopIsPlaying = NO;
    
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
    if (_volumeChanged == NO) {
    audioPlayer5.volume = _initialVolume;
    }
    else audioPlayer5.volume = currentVolume;
    [audioPlayer5 play];
}

- (IBAction)Button6Pressed:(UIButton *)sender {
    [_button6 setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"ChuToy" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer6 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
    audioPlayer6.volume = _initialVolume;
    }
    else audioPlayer6.volume = currentVolume;
    [audioPlayer6 play];
}

- (IBAction)Button7Pressed:(UIButton *)sender {
    [_button7 setBackgroundImage:[self imageWithColor:[UIColor brownColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Pong2003" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer7 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
    audioPlayer7.volume = _initialVolume;
    }
    else audioPlayer7.volume = currentVolume;
    [audioPlayer7 play];
}

- (IBAction)Button8Pressed:(UIButton *)sender {
    [_button8 setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Boing" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer8 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
    audioPlayer8.volume = _initialVolume;
    }
    else audioPlayer8.volume = currentVolume;
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
    
    
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft   | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

// Become first responder whenever the view appears
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    // Locate the documents directory
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDirectory = [paths objectAtIndex:0];
//    
//    //creates the full path to our data file
//    NSString *filePath =  [docDirectory stringByAppendingPathComponent:kFilename];
//    
//    NSArray *fileArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    
    
//    NSLog(@"passed in volume at: %0.1f", passedinVolume);
//    NSLog(@"passed in replay at: %f", passedinRate);
//    NSLog(@"passed in panning at: %f", passedinPanning);
//    NSLog(@"Volume Changed: %hhd", _volumeChanged);
//    NSLog(@"Rate Changed: %hhd", _replayChanged);
//    NSLog(@"Panning Changed: %hhd", _panningChanged);
//    
//    if (_volumeChanged) {
//        currentVolume = passedinVolume;
//    }
//    else currentVolume = _initialVolume;
//    
//    if (_replayChanged) {
//        currentReplaySpeed = passedinRate;
//    }
//    else currentReplaySpeed = _initialReplaySpeed;
//    
//    if (_panningChanged) {
//        currentPan = passedinPanning;
//    }
//    else currentPan = _initialPan;
//    
//    NSLog(@"End of appear, volume is: %0.1f", currentVolume);
//    NSLog(@"End of appear, replay is: %f", currentReplaySpeed);
//    NSLog(@"End of appear, pan is: %f", currentPan);

}

// Resign first responder whenever the view disappears
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {   //for NOW, keeping this just as pass-ins from Play1...
//    NSLog(@"passed in volume at: %0.1f", passedinVolume);
//    NSLog(@"passed in replay at: %f", passedinRate);
//    NSLog(@"passed in panning at: %f", passedinPanning);
//    NSLog(@"Volume Changed: %hhd", _volumeChanged);
//    NSLog(@"Rate Changed: %hhd", _replayChanged);
//    NSLog(@"Panning Changed: %hhd", _panningChanged);
//    
//    if (_volumeChanged) {
//        _currentVolume = passedinVolume;
//        }
//    else _currentVolume = _initialVolume;
//    
//    if (_replayChanged) {
//        _currentReplaySpeed = passedinRate;
//    }
//    else _currentReplaySpeed = _initialReplaySpeed;
//    
//    if (_panningChanged) {
//        _currentPan = passedinPanning;
//    }
//    else _currentPan = _initialPan;
//    
//    NSLog(@"End of appear, volume is: %0.1f", _currentVolume);
//    NSLog(@"End of appear, replay is: %f", _currentReplaySpeed);
//    NSLog(@"End of appear, pan is: %f", _currentPan);
    
    //Set label text here, because that's the only thing getting passed back to Play1...
    
    //Testing pass-in from Play1...   works!
//    NSLog(@"Options View passed in volume at: %0.1f", passedinVolume);
//    NSLog(@"Options View passed in replay at: %f", passedinRate);
//    NSLog(@"Options View passed in panning at: %f", passedinPanning);
    
        
    //Set variables to passed-in values from View 1:
    
//    optionsVolumeValue.value = passedinVolume;
//    optionsRateValue.value = passedinRate;
//    optionsPanningSlider.value = passedinPanning;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    //creates the full path to our data file
    NSString *filePath =  [docDirectory stringByAppendingPathComponent:kFilename];
    
    NSArray *fileArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    CGFloat newVol = [fileArray[0] doubleValue];
    CGFloat newRep = [fileArray[1] doubleValue];
    CGFloat newPan = [fileArray[2] doubleValue];
    CGFloat volChanged = [fileArray[3] doubleValue];
    CGFloat repChanged = [fileArray[4] doubleValue];
    CGFloat panChanged = [fileArray[5] doubleValue];
    
    NSLog(@"What's that sound, %f", newVol);
    NSLog(@"What's that rate, %f", newRep);
    NSLog(@"What's that pan, %f", newPan);
    NSLog(@"What's that vol change, %f", volChanged);
    NSLog(@"What's that rep change, %f", repChanged);
    NSLog(@"What's that pan change, %f", panChanged);
    
    if (volChanged == 1) {
        currentVolume = newVol;
        _volumeChanged = YES;
    }
    else {currentVolume = _initialVolume;
        _volumeChanged = NO;
        }
    
    if (repChanged == 1) {
        currentReplaySpeed = newRep;
        _replayChanged = YES;
    }
    else {
        currentReplaySpeed = _initialReplaySpeed;
        _replayChanged = NO;
    }
    
    if (panChanged == 1) {
        currentPan = newPan;
        _panningChanged = YES;
    }
    else {
        currentPan = _initialPan;
        _panningChanged = NO;
    }
    
    NSLog(@"End of ViewWillAppear that sound, %f", currentVolume);
    NSLog(@"End of ViewWillAppear that rate, %f", currentReplaySpeed);
    NSLog(@"End of ViewWillAppear that pan, %f", currentPan);
    NSLog(@"End that vol change, %hhd", _volumeChanged);
    NSLog(@"End that rep change, %hhd", _replayChanged);
    NSLog(@"End that pan change, %hhd", _panningChanged);
    
    
    
//    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
//    [format setNumberStyle:NSNumberFormatterDecimalStyle];
//    
//    NSNumber *readinVol = [format numberFromString: fileArray [0]];
//    
//    CGFloat readVol = [readinVol floatValue] * _volFloat;
    
    // NSLog([fileArray objectAtIndex:0]) ; We know it's there...
    //NSLog(@"Hey! It's a %f", readVol);
    //NSLog(@"What's this do: %f", _volFloat);
    //NSString *volumeFromPlay1 = options.volumeLabel.text; //READ IN FROM PLIST OBJECTATINDEX 0 HERE
    //CGFloat newVolume = [volumeFromPlay1 floatValue];
    //currentVolume = newVolume;
}



//Shake method:
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"DID SHAKE!");
    
    //Implement after passing in new variables:
    
    if (loopIsPlaying){
        [audioPlayerLoop stop];
        loopIsPlaying = NO;
    }
    else { // Here's what will happen if the loop isn't playing:
        if (_volumeChanged == NO) {
            audioPlayerLoop.volume = _initialVolume;
        }
        else {
            audioPlayerLoop.volume = currentVolume;
        }
        if (_replayChanged) {
            audioPlayerLoop.rate = currentReplaySpeed;
        }
        else audioPlayerLoop.rate = _initialReplaySpeed;
        
        NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"loopypoo" ofType:@"wav"];
        NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
        audioPlayerLoop = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        audioPlayerLoop.numberOfLoops = -1;
        
        
        
        [audioPlayerLoop play];
        loopIsPlaying = YES;
    }
    
}


-(void) updiz {
    
    
}

- (IBAction)unwindToPlay2ViewControllerFromOptions:(UIStoryboardSegue *)unwindSegue{
    OptionsViewController *options = unwindSegue.sourceViewController;
    
    //Declare new strings, and convert to floats for things passed in for Volume:
    NSString *volumeText = options.volumeLabel.text;
    CGFloat newVolume = [volumeText floatValue];
    currentVolume = newVolume;
    
    //Declare new strings and floats for things passed in for Replay Speed:
    NSString *replayText = options.replayLabel.text;
    CGFloat newReplaySpeed = [replayText floatValue];
    currentReplaySpeed = newReplaySpeed;
    
    //Declare new strings and floats for things passed in for Panning:
    NSString *panningText = options.panningLabel.text;
    CGFloat newPanning = [panningText floatValue];
    currentPan = newPanning;
    
    //    if (panningValueFromOptions >= 0.00001 || panningValue <= 0.00001) {
    //        _panningChanged = YES;
    //        NSLog(@"Panning %hhd", _panningChanged);}
    //    else if (panningValue == 0) {
    //        _panningChanged = NO;
    //    }
    
    //DO I STILL NEED?
    //See if the user changed the volume. If so, pass in new Volume:
    if (_volumeChanged == NO && (newVolume != _initialVolume)) { // volume has not been changed before, so change it
        _volumeChanged = YES;
        currentVolume = newVolume;
    } else if (_volumeChanged == YES && newVolume != currentVolume) { // volume has been changed before and is different, so change it again
        _volumeChanged = YES;
        currentVolume = newVolume;
    }
    
    //See if user changed the replay speed. If so, pass in new Replay:
    if (_replayChanged == NO && (newReplaySpeed != _initialReplaySpeed)) { // replay has not been changed before, so change it
        _replayChanged = YES;
        currentReplaySpeed = newReplaySpeed;
    } else if (_replayChanged == YES && newReplaySpeed != currentReplaySpeed) { // replay has been changed before and is different, so change it again
        _replayChanged = YES;
        currentReplaySpeed = newReplaySpeed;
    }
    
    //See if user changed the Panning. If so, pass in new Panning:
    if (_panningChanged == NO && (newPanning != _initialPan)) { // Panning has not been changed before, so change it
        _panningChanged = YES;
        currentPan = newPanning;
    } else if (_panningChanged == YES && newPanning != currentPan) { // Panning has been changed before and is different, so change it again
        _panningChanged = YES;
        currentPan = newPanning;
    }
    
    NSString *filePath=[self getMyData];
    //Use variable names specific to this VC:
    //    currentVolume = _optionsVolume;
    //    currentReplaySpeed = _replay;
    //    currentPan = _optionsPanning;
    //    _volumeChanged1 = _volumeChanged;
    //    _replayChanged1 = _replayChanged;
    //    _panningChanged1 = _panningChanged;
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    //1-6, make 'em strings:
    NSString *volume = [NSString stringWithFormat:@"%f", currentVolume];
    NSString *playrate = [NSString stringWithFormat:@"%f", currentReplaySpeed];
    NSString *pan = [NSString stringWithFormat:@"%f", currentPan];
    NSString *volumechange=[NSString stringWithFormat:@"%hhd", _volumeChanged];
    NSString *ratechange=[NSString stringWithFormat:@"%hhd", _replayChanged];
    NSString *panchange=[NSString stringWithFormat:@"%hhd", _panningChanged];
    
    array = [NSArray arrayWithObjects:volume, playrate, pan, volumechange, ratechange, panchange, nil];
    [array writeToFile:filePath atomically:YES];
    NSLog(@"Wrote %f to array for Volume", currentVolume);
    NSLog(@"Wrote %f to array for Replay", currentReplaySpeed);
    NSLog(@"Wrote %f to array for Replay", currentPan);
    NSLog(@"Wrote %hhd to array for Vol Change", _volumeChanged);
    NSLog(@"Wrote %hhd to array for Rep Change", _replayChanged);
    NSLog(@"Wrote %hhd to array for Pan Change", _panningChanged);
    
    
}

-(NSString *)getMyData{
    //locates the document directory
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}


@end
