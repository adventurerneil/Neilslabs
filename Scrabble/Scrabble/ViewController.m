//
//  ViewController.m
//  Scrabble
//
//  Created by Neil Dimuccio on 10/22/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *words;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"qwordswithoutu1" ofType:@"plist"];
    words=[[NSArray alloc] initWithContentsOfFile:plistPath];
    self.title=@"Words";
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [words count];  //returns the number of words
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[words objectAtIndex:indexPath.row];
    return cell;
}

//UITableViewDelegate method that is called when a row is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *rowValue=[words objectAtIndex:indexPath.row];
    
    //sets the title of the selected row
    NSString *message=[[NSString alloc] initWithFormat:@"You selected %@", rowValue];
                       UIAlertView *alert=[[UIAlertView alloc]
                                           initWithTitle:@"Row Selected"
                                           message:message delegate:nil cancelButtonTitle:@"Mmhhmm"
                                           otherButtonTitles:nil];
                       [alert show];
                       [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
                       //deselects the row that had been choosen
                       }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
