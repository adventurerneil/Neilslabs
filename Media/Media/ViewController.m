//
//  ViewController.m
//  Media
//
//  Created by Neil Dimuccio on 11/19/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIImage *image;
    NSURL *videoURL;
    AVAudioPlayer *audioPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate=self;
        imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes=[NSArray arrayWithObjects:(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie, nil];
        [self presentViewController:imagePickerController animated:YES completion:NULL];
    
    }
    else{
        NSLog(@"Can't access the camera");
    }
}

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    if (image || videoURL)
    {
        [actionSheet addButtonWithTitle:@"Save"];
    }
    [actionSheet addButtonWithTitle:@"Camera Roll"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet addButtonWithTitle:@"Play Audio"];
    actionSheet.cancelButtonIndex=actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Save"])
    {
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
        //ELSEIF VIDEO
        else if (videoURL)
        {
            //convert URL to a string
            NSString *urlString = [videoURL path];
            //checks that the device can save video to the cameraroll as not all devices can
            if
                (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString)) {//save video to the camera roll
                    UISaveVideoAtPathToSavedPhotosAlbum(urlString,self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
                }
        }
        
    }
    else if ([buttonTitle isEqualToString:@"Camera Roll"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imagePickerController.allowsEditing=NO;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES
                     completion:NULL];
        
    }
    
    else if ([buttonTitle isEqualToString:@"Play Audio"]) {
        //use NSBundle to get the file path
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"loopypoo" ofType:@"wav"];
        //build an URL object
        NSURL *fileURL = [NSURL URLWithString:soundFilePath];
        //initialize the player with the file URL
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        //set delegate so you can know when the sound clip is done
        audioPlayer.delegate = self; //play the sound file
        audioPlayer.numberOfLoops = -1;
        [audioPlayer play]; }

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError
                                                         *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        NSLog(@"Error! %@", [error localizedDescription]);
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Image saved"
                                  message:@"Image saved successfully to camera roll."
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

//called after successfully taking a picture or video
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //determines whether it was a picture or a video
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    image = nil;
    _imageView.image = nil;
    videoURL = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        //picture
    {
        //the original, unmodified image from the camera
        UIImage *originalImage = [info
                                  objectForKey:UIImagePickerControllerOriginalImage];
        //the final, edited image if editing was enabled.
        UIImage *editedImage = [info
                                objectForKey:UIImagePickerControllerEditedImage];
        image = editedImage ? editedImage : originalImage;
        _imageView.image = image;
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) //video
    {
        videoURL= [info objectForKey:UIImagePickerControllerMediaURL]; }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//called when the user taps the cancel button in the camera view
- (void)imagePickerControllerDidCancel:(UIImagePickerController
                                        *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"Error! %@", [error localizedDescription]); }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Video saved" message:@"Video saved successfully to camera roll." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show]; }
}

//called when the audio file finishes playing
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    audioPlayer = nil; }
//called if an error ocurred decoding the audio file
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    audioPlayer = nil; }


@end
