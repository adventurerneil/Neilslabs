//
//  OptionsViewController.m
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "OptionsViewController.h"
#define kFilename @"data.plist"

@interface OptionsViewController ()


@end

@implementation OptionsViewController 

//Passed in values:
@synthesize passedinPanning;
@synthesize passedinRate;
@synthesize passedinVolume;

//Lables for sliders:
@synthesize volumeLabel;
@synthesize replayLabel;
@synthesize panningLabel;
//Slider values:
@synthesize optionsVolumeValue;
@synthesize optionsRateValue;
@synthesize optionsPanningSlider;
@synthesize delegate = _delegate;
//More synth:
@synthesize volumeValueFromOptions;
@synthesize panningValueFromOptions;
@synthesize replayValueFromOptions;
//Passed in values:
@synthesize currentVolume;
@synthesize currentReplaySpeed;
@synthesize currentPan;


//-(IBAction)returnButtonPressed:(id)sender{
//    [self.delegate done:someText.text];
//}

//
//@synthesize someText;
//



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set rate for playback
    _initialReplaySpeed = 1.0f;
    
    // Set initial Volume
    _initialVolume = 0.8f;
    
    // Set initial Pan
    _initialPan = 0.0f;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (IBAction)optionsVolume:(UISlider *)sender {
    //UISlider *slider = (UISlider *)sender;
    //float optionsVolume = slider.value;
    volumeValue=sender.value;
    volumeLabel.text=[NSString stringWithFormat:@"%f", volumeValue];
}

- (IBAction)optionsRate:(UISlider *)sender {
    replayValue=sender.value;
    replayLabel.text=[NSString stringWithFormat:@"%f", replayValue];
}
*/
 
//- (IBAction)buttonsChanger:(id)sender {
//}

- (IBAction)panningSlider:(UISlider *)sender {
    panningValueFromOptions=sender.value;
    panningLabel.text=[NSString stringWithFormat:@"%0.1f", panningValueFromOptions];
    
}

-(IBAction)volumeSlider:(UISlider *)sender{
    volumeValueFromOptions=sender.value;
    volumeLabel.text=[NSString stringWithFormat:@"%0.1f", volumeValueFromOptions];
//    if (volumeValue >= 0.80001 || volumeValue <= 0.7999) {
//        _volumeChanged = YES;
//        NSLog(@"Volume %hhd", _volumeChanged);}
//    else if (volumeValue == 0.8) {
//        _panningChanged = NO;
//    }
    
    
}

- (IBAction)replaySlider:(UISlider *)sender{
    replayValueFromOptions=sender.value;
    replayLabel.text=[NSString stringWithFormat:@"%0.1f", replayValueFromOptions];
//    if (replayValue >= 1.00001 || replayValue <= 0.9999) {
//        _replayChanged = YES;
//        NSLog(@"Replay %hhd", _replayChanged);}
//    else if (replayValue == 1.0) {
//        _replayChanged = NO;
//    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    //Set label text here, because that's the only thing getting passed back to Play1...
    
    //Testing pass-in from Play1...   works!
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
        volumeLabel.text = [NSString stringWithFormat:@"%0.1f", currentVolume];
        optionsVolumeValue.value = currentVolume;
    }
    else {
        currentVolume = _initialVolume;
        _volumeChanged = NO;
        volumeLabel.text = [NSString stringWithFormat:@"%0.1f", _initialVolume];
        optionsVolumeValue.value = _initialVolume;
    }
    
    if (repChanged == 1) {
        currentReplaySpeed = newRep;
        _replayChanged = YES;
        replayLabel.text = [NSString stringWithFormat:@"%0.1f", currentReplaySpeed];
        optionsRateValue.value = currentReplaySpeed;
    }
    else {
        currentReplaySpeed = _initialReplaySpeed;
        _replayChanged = NO;
        replayLabel.text = [NSString stringWithFormat:@"%0.1f", _initialReplaySpeed];
        optionsRateValue.value = _initialReplaySpeed;
    }
    
    if (panChanged == 1) {
        currentPan = newPan;
        _panningChanged = YES;
        panningLabel.text = [NSString stringWithFormat:@"%0.1f", currentPan];
        optionsPanningSlider.value = currentPan;
    }
    else {
        currentPan = _initialPan;
        _panningChanged = NO;
        panningLabel.text = [NSString stringWithFormat:@"%0.1f", _initialPan];
        optionsPanningSlider.value = _initialPan;
    }
    
    NSLog(@"End of ViewWillAppear that sound, %f", currentVolume);
    NSLog(@"End of ViewWillAppear that rate, %f", currentReplaySpeed);
    NSLog(@"End of ViewWillAppear that pan, %f", currentPan);
    NSLog(@"End that vol change, %hhd", _volumeChanged);
    NSLog(@"End that rep change, %hhd", _replayChanged);
    NSLog(@"End that pan change, %hhd", _panningChanged);
    
    
    
}

-(IBAction)saveButtonPressed:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{  //Not getting called at all, due to unwind!
    
    NSLog(@"IS THIS EVEN GETTING CALLED");
    
    OptionsViewController *options = segue.sourceViewController;
    
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

//    
//    if ([[segue identifier] isEqualToString:@"optionsSegue"]) {
//        NSLog(@"PrepareForSegue in OptionsView - Identifier triggered!");
//    }
    
    
    // Get destination view
    //PlayViewController *vc = [segue destinationViewController];
    
//    // These SHOULD update the corresponding values in the destination ViewController...
//    if (_volumeChanged) {
//        vc.optionsVolume = optionsVolumeValue.value;
//        [vc setVolumeChanged:YES];
//    }
//    //else vc.optionsVolume
//    //  vc.replay = _initalVolume.value;
//    
//    //[vc setOptionsVolume:volumeValue];
//    //[vc setReplay:replayValue];
//    
//    vc.replay = optionsRateValue.value;
//    vc.optionsPanning = optionsPanningSlider.value;
//    
//    [vc setReplayChanged:YES];
//    [vc setPanningChanged:YES];
//    
//    
//    
//    NSString *itemToPassBack = @"Pass this value back to ViewControllerA";
//    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
//    
    // Set the selected button in the new view
    //[vc setSelectedButton:tagIndex];
    
    //UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
    //PlayViewController *controller = (PlayViewController *)navController.topViewController;
    //controller.isSomethingEnabled = YES;
    
-(NSString *)getMyData{
    //locates the document directory
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}


@end
