//
//  ViewController.m
//  Animatron
//
//  Created by Neil Dimuccio on 11/14/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    CGPoint delta;
    NSTimer *timer;
    CGPoint translation;
    float angle; //angle for rotation
    float ballRadius;
}

-(IBAction)changeSliderValue
{
    _sliderLabel.text=[NSString stringWithFormat:@"%.2f", _slider.value];
    timer = [NSTimer scheduledTimerWithTimeInterval:_slider.value target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    angle=0; //sets angle to 0
    ballRadius=_imageView.frame.size.width/2;
    delta=CGPointMake(12.0, 4.0);
    translation = CGPointMake(0.0, 0.0);
    [self changeSliderValue];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) onTimer {

    //-(void) onTimer {
        //changes the position by setting a new center of the image view
        [UIView beginAnimations:@"my_own_ainmation" context:nil];
        [UIView animateWithDuration:_slider.value
                              delay:0
                            options:UIViewAnimationCurveLinear
                         animations:^{_imageView.transform = CGAffineTransformMakeScale(angle,angle);}
                         completion:NULL];
        [UIView commitAnimations];
        angle += .009;
        if (angle>2*M_PI)
            angle=0;
        _imageView.center = CGPointMake(_imageView.center.x + delta.x, _imageView.center.y + delta.y);
        
        //if the image touched the sides of the screen it reverses the direction
        if (_imageView.center.x >
            self.view.bounds.size.width - ballRadius || _imageView.center.x <
            ballRadius)
            delta.x = -delta.x;
        if (_imageView.center.y >
            self.view.bounds.size.height - ballRadius || _imageView.center.y <
            ballRadius)
            delta.y = -delta.y;
    }
    
    
//    [UIView beginAnimations:@"my_own_animation" context:nil];
//    [UIView animateWithDuration:_slider.value delay:0 options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{_imageView.transform = CGAffineTransformMakeScale(angle,angle);
//                         _imageView.center = CGPointMake(_imageView.center.x + delta.x, _imageView.center.y + delta.y);}
//                     completion:NULL];
//    angle += 0.02; //amount by which you increment the angle //if it's a full rotation reset the angle
//    if (angle>2*M_PI)
//        angle=0;
//    [UIView commitAnimations];
//    
//    //_imageView.center = CGPointMake(_imageView.center.x + delta.x, _imageView.center.y + delta.y);
//    if (_imageView.center.x + self.view.bounds.size.width - ballRadius || _imageView.center.x < ballRadius)
//        delta.x = -delta.x;
//    if (_imageView.center.y + self.view.bounds.size.height - ballRadius || _imageView.center.y < ballRadius)
//        delta.y = -delta.y;
//    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(UISlider *)sender {
    [timer invalidate];
    [self changeSliderValue];
    
}
@end
