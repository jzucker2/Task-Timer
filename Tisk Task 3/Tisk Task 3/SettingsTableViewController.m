//
//  SettingsTableViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "SettingsTableViewController.h"

@implementation SettingsTableViewController

@synthesize versionArray, findMoreArray;

//@synthesize settingsArray;
//@synthesize sortedKeys, tableContents;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *versionString = [NSString stringWithFormat:@"Version %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    NSString *buildString = [NSString stringWithFormat:@"Build %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    versionArray = [[NSArray alloc] initWithObjects:versionString, buildString, nil];
    

    
    NSString *author = @"Jordan Zucker";
    NSString *date = @"December 2011";
    
    NSString *sendEmail = @"Send me an email!";
    //[settingsArray addObject:sendEmail];
    
    NSString *visitMe = @"Visit my website";
    
    findMoreArray = [[NSArray alloc] initWithObjects:author, date, sendEmail, visitMe, nil];
    
    //NSString *stats = @"Statistics";
    
    
    
    //[settingsArray addObject:stats];
    
    //tableContents = [[NSMutableDictionary alloc] initWithObjectsAndKeys:versionDict, @"About", findMoreArray, @"Find out more", nil
    //NSMutableArray *versionArray = [[NSMutableArray alloc] initWithObjects:versionDict, build, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 4;
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    switch (section) {
        case 0:
            title = @"App Info";
            break;
        case 1:
            title = @"About Me";
            break;
            
        default:
            title = nil;
            break;
    }
    return  title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = [versionArray count];
            break;
        case 1:
            rows = [findMoreArray count];
            break;
        case 2:
            rows = 1;
            break;
        case 3:
            rows = 1;
            break;
        default:
            rows = 0;
            break;
    }
    return rows;
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return [settingsArray count];
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = [versionArray objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [findMoreArray objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = @"Statistics";
            break;
        case 3:
            cell.textLabel.text = @"Rate this app!";
            break;
            
        default:
            break;
    }
    //cell.textLabel.text = [settingsArray objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 1:
            switch (indexPath.row) {
                case 2:
                    NSLog(@"send email");
                    break;
                case 3:
                    NSLog(@"visit website");
                    break;
                default:
                    [tableView deselectRowAtIndexPath:indexPath animated:NO];
                    break;
            }
            break;
        case 2:
            NSLog(@"View stats");
            break;
        case 3:
            NSLog(@"Rate app");
            break;
            
        default:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [versionArray release];
    [findMoreArray release];
    //[sortedKeys release];
    //[tableContents release];
    //[settingsArray release];
    [super dealloc];
}

@end
