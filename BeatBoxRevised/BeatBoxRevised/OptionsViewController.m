//
//  OptionsViewController.m
//  BeatBoxRevised
//
//  Created by Neil Dimuccio on 11/10/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()


@end

@implementation OptionsViewController 

@synthesize volume;
@synthesize rate;
@synthesize volumeLabel;
@synthesize replayLabel;
@synthesize panningLabel;
@synthesize optionsVolumeValue;
@synthesize optionsRateValue;
@synthesize optionsPanningSlider;
@synthesize delegate = _delegate;

//-(IBAction)returnButtonPressed:(id)sender{
//    [self.delegate done:someText.text];
//}

//
//@synthesize someText;
//
//Set default values for 3 sound variables
float volumeValue = 80;
float replayValue = 1;
float panningValue = 0;


//Declare Bools for if values are changed:
BOOL volumeChanged;
BOOL replayChanged;
BOOL panningChanged;

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
    panningValue=sender.value;
    panningLabel.text=[NSString stringWithFormat:@"%0.1f", panningValue];
    panningChanged = YES;
    
}

-(IBAction)volumeSlider:(UISlider *)sender{
    volumeValue=sender.value;
    volumeLabel.text=[NSString stringWithFormat:@"%0.1f", volumeValue];
    volumeChanged = YES;
    
}

- (IBAction)replaySlider:(UISlider *)sender{
    replayValue=sender.value;
    replayLabel.text=[NSString stringWithFormat:@"%0.1f", replayValue];
    replayChanged = YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepare 1 in options");
    if([segue.identifier isEqualToString:@"optionsSegue"]){
        NSLog(@"prepare 2 in options");}  //double check this IF...
    
        // Get destination view
        PlayViewController *vc = [segue destinationViewController];
        
        // These SHOULD update the corresponding values in the destination ViewController...
    if (volumeChanged) {
        vc.optionsVolume = optionsVolumeValue.value;
    }
    //else vc.optionsVolume
      //  vc.replay = _initalVolume.value;
        
        //[vc setOptionsVolume:volumeValue];
        //[vc setReplay:replayValue];
        [vc setVolumeChanged:YES];
        [vc setReplayChanged:YES];
        
        
        // Set the selected button in the new view
        //[vc setSelectedButton:tagIndex];
        
        //UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        //PlayViewController *controller = (PlayViewController *)navController.topViewController;
        //controller.isSomethingEnabled = YES;
    
}




@end
