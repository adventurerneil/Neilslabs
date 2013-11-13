//
//  ViewController.m
//  Countries
//
//  Created by Neil Dimuccio on 10/24/13.
//  Copyright (c) 2013 Neil Dimuccio. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "ContinentInfoViewController.h"


@interface ViewController () {
    NSMutableDictionary *continentData;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    continentData = dictionary;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return [continentData count]; //returns the number of continents
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    NSArray *rowData=[continentData allKeys]; //creates an array with all keys from our dictionary
    cell.textLabel.text=[rowData objectAtIndex:indexPath.row];
    //sets the text of the cell with the row being requested
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"continentsegue"]) {
        ContinentInfoViewController *infoViewController = segue.destinationViewController;
        //DetailViewController *countryViewController=segue.destinationViewController;
        //NSIndexPath *indexPath=[self.tableView indexPathForCell:sender]; //SelectedRow];
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        NSArray *rowData=[continentData allKeys]; //creates an array with all keys from our dictionary
        infoViewController.name=[rowData objectAtIndex:indexPath.row];
        infoViewController.number=[NSString stringWithFormat:@"%d",
        [[continentData objectForKey:infoViewController.name] count]];
        //countryViewController.title=[rowData objectAtIndex:indexPath.row];
        //countryViewController.countryList=[continentData objectForKey:countryViewController.title];
    } else if ([segue.identifier isEqualToString:@"countrysegue"]) {
        DetailViewController *countryViewController=segue.destinationViewController;
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        NSArray *rowData=[continentData allKeys]; //creates an array with all keys from our dictionary
        //NSLog(@"country: %@", [rowData objectAtIndex:indexPath.row]);
        //DetailViewController *countryViewController=segue.destinationViewController;
        //NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        //NSArray *rowData=[continentData allKeys]; //creates an
        //array with all keys from our dictionary
        countryViewController.title=[rowData objectAtIndex:indexPath.row];
        countryViewController.countryList=[continentData objectForKey:countryViewController.title];
    
        
        countryViewController.countryName=[rowData objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
