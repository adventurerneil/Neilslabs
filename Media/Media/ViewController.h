//
//  ViewController.h
//  Media
//
//  Created by Neil Dimuccio on 11/19/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender;

@end
