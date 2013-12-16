//
//  PlayViewController.m
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "PlayViewController.h"
#define kFilename @"data.plist"


@interface PlayViewController (){
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    AVAudioPlayer *audioPlayerLoop;
}

@end

@implementation PlayViewController

//Passed in values:
@synthesize currentVolume;
@synthesize currentReplaySpeed;
@synthesize currentPan;

- (void)viewDidLoad
{
    [super viewDidLoad];
	isFirstTime = YES;
    loopIsPlaying = NO;
    // Disable Stop/Play button when application launches
//    [_stopButton setEnabled:NO];
//    [_playButton setEnabled:NO];
    
    // Set the audio file for recording 
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
    
    //[recordSetting setValue:AVEncoderAudioQualityKey: @(AVAudioQualityMedium)];
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
    

}



- (IBAction)button1Pressed:(UIButton *)sender {
    [_button1 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Volume" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer1.volume = _initialVolume;
    }
    else audioPlayer1.volume = currentVolume;
    [audioPlayer1 play];
}

- (IBAction)button2Pressed:(UIButton *)sender {
    [_button2 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Select" ofType:@"wav"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    if (_volumeChanged == NO) {
        audioPlayer2.volume = _initialVolume;
        NSLog(@"player 2 if vol: %f", audioPlayer2.volume);
    }
    else {
        audioPlayer2.volume = currentVolume;
        NSLog(@"player 2 else vol: %f", audioPlayer2.volume);
    }
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
    else audioPlayer3.volume = currentVolume;
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
        NSLog(@"Play replay speed else 2: %f", _replay);}
        
                
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        
        
        [player setDelegate:self];
        [player play];
    }
}

- (IBAction)repeatPressed:(UIButton *)sender {
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        if (_replayChanged == NO) {
            player.rate=_initialReplaySpeed; }
        else if (_replayChanged == YES) {
            player.rate=currentReplaySpeed;}
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
    [_stopButton setEnabled:YES];
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

- (IBAction)unwindToPlayViewControllerFromOptions:(UIStoryboardSegue *)unwindSegue{
    
    
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
    } else if (_panningChanged == YES && newPanning != _optionsPanning) { // Panning has been changed before and is different, so change it again
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
    
    //NSLog([array objectAtIndex:0]) ;
//    if ([[array objectAtIndex:0] isEqual: @"1.000000"]) {
//        
//    }
    
    NSLog(@"End of unwind, volume is: %0.1f", newVolume);
    NSLog(@"End of unwind, replay is: %f", newReplaySpeed);
    NSLog(@"End of unwind, panning is: %f", newPanning);
    NSLog(@"Volume Changed: %hhd", _volumeChanged);
    NSLog(@"Rate Changed: %hhd", _replayChanged);
    NSLog(@"Panning Changed: %hhd", _panningChanged);
    
    //NSLog(@"in unwind: %f", _optionsVolume);
//    audioPlayer1.volume = _optionsVolume;
//    audioPlayer2.volume = _optionsVolume;
//    audioPlayer3.volume = _optionsVolume;
//    audioPlayer4.volume = _optionsVolume;
//    player.rate = _replay;   // double check this...
}

- (IBAction)unwindToPlayViewControllerFromPlay2:(UIStoryboardSegue *)unwindSegue{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"PLAY1 Volume Changed: %hhd", _volumeChanged);
    //if...
    //OptionsViewController *ViewController = segue.destinationViewController;
    
    [audioPlayerLoop stop];
//    currentVolume = _optionsVolume;
//    currentReplaySpeed = _replay;
//    currentPan = _optionsPanning;
//    _volumeChanged1 = _volumeChanged;
//    _replayChanged1 = _replayChanged;
//    _panningChanged1 = _panningChanged;
    
    
    
    //Pass variables to OptionsViewController so sliders are set correctly:
    //NSLog(@"prepareForSegue: %@", segue.identifier);
    //if  ([segue.identifier isEqualToString:@"play2segue"])
    //{
//        //NSLog(@"prepareForSegue: %@", segue.identifier);
      //  Play2ViewController *vc = [segue destinationViewController];
//        
        //if (_volumeChanged1){
          //  vc.passedinVolume = currentVolume;
//            vc.volumeChanged = YES;
            //NSLog(@"WTF");}
//        else {
//            vc.passedinVolume = _initialVolume;
//            vc.volumeChanged = NO;}
//        
//        if (_replayChanged1 == YES){
//            vc.passedinRate = currentReplaySpeed;
//            vc.replayChanged = YES;}
//        else {
//            vc.passedinRate = _initialReplaySpeed;
//            vc.replayChanged = NO;}
//        
//        if (_panningChanged1 == YES){
//            vc.passedinPanning = currentPan;
//            vc.panningChanged = YES;}
//        else {
//            vc.passedinPanning = _initialPan;
//            vc.panningChanged = NO;}
//        NSLog(@"PLAY1 Volume Changed: %hhd", _volumeChanged);
//        NSLog(@"PLAY1 Rate Changed: %hhd", _replayChanged);
//        NSLog(@"PLAY1 Panning Changed: %hhd", _panningChanged);
//        
    //}
//
    
    
//    if ([segue.identifier isEqualToString:@"optionsSegue"])
//    {
//        OptionsViewController *vc = [segue destinationViewController];  //Will need to incorporate Play2...
//        
//        //Set slider values:
//        if (_volumeChanged1 == YES){
//            vc.passedinVolume = _optionsVolume; }
//        else {
//            vc.passedinVolume = _initialVolume; }
//        
//        if (_replayChanged1 == YES){
//            vc.passedinRate = _replay; }
//        else {
//            vc.passedinRate = _initialReplaySpeed; }
//        
//        if (_panningChanged1 == YES){
//            vc.passedinPanning = _optionsPanning;}
//        else {
//            vc.passedinPanning = _initialPan;}
//    }
}


/*-(void)done:(NSString *)name {
    [self dismissViewControllerAnimated:YES completion:nil];
    _VolumeOutput.text=name;
}*/

- (IBAction)done:(UIStoryboardSegue *)segue {
    NSLog(@"Done method triggered");
    /*ConfirmationViewController *cc = [segue sourceViewController];
    [self setAccountInfo:[cc accountInfo]];
    [self setShowingSuccessView:YES];*/
}



- (BOOL) shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft   | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)viewWillAppear:(BOOL)animated {
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

    
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

// Become first responder whenever the view appears
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
        
    
    
    
}

// Resign first responder whenever the view disappears
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

//Shake method: 
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"DID SHAKE!");
    
    if (loopIsPlaying){
        [audioPlayerLoop stop];
        loopIsPlaying = NO;
    }
    else { // Here's what will happen if the loop isn't playing:
        if (_volumeChanged == NO) {
            audioPlayerLoop.volume = _initialVolume;
        }
        else {
            audioPlayerLoop.volume = _optionsVolume;
        }
        if (_replayChanged) {
            audioPlayerLoop.rate = _replay;
        }
        else audioPlayerLoop.rate = _initialReplaySpeed;

        
        NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"loopypoo" ofType:@"wav"];
        NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
        audioPlayerLoop = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        audioPlayerLoop.numberOfLoops = -1;
        
        

        [audioPlayerLoop play];
        loopIsPlaying = YES;
    }
    
    // Play a sound whenever a shake motion starts:
//    if (motion != UIEventSubtypeMotionShake) return;
//    [self playSound:startSound];
    
}

- (void)addItemViewController:(OptionsViewController *)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item);
}

-(NSString *)getMyData{
    //locates the document directory 
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}

@end
