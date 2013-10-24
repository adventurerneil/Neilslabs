//
//  ViewController.m
//  Music
//
//  Created by Neil Dimuccio on 10/3/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *genre = [[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", @"Indie", nil];
    _genre=genre;
    NSArray *decade = [[NSArray alloc] initWithObjects:@"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
	_decade=decade;
    // Do any additional setup after loading the view, typically from a nib.
}

//Picker methods:

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0)
    return [_genre count];
    else return [_decade count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0)
    return [_genre objectAtIndex:row];
    else return [_decade objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger genrerow=[_musicPicker selectedRowInComponent:0];
    NSInteger decaderow=[_musicPicker selectedRowInComponent:1];
    _choiceLabel.text=[NSString stringWithFormat:@"You'll dance to %@ from the %@!", [_genre objectAtIndex:genrerow], [_decade objectAtIndex:decaderow]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
