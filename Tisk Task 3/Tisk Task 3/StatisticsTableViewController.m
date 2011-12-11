//
//  StatisticsTableViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "StatisticsTableViewController.h"
#import "CountdownFormatter.h"

@implementation StatisticsTableViewController

@synthesize notificationsArray, allTasksArray, todayTasksArray, historyArray, metadata;
@synthesize notificationsKeysArray, allTasksKeysArray, todayTasksKeysArray, historyKeysArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        // import metadata
        MetaDataWrapper *metadataWrapper = [[MetaDataWrapper alloc] init];
        metadata = [[metadataWrapper fetchPList] retain];
        [metadataWrapper release];
        //NSLog(@"in stats: metadata is %@", metadata);
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // import metadata
        MetaDataWrapper *metadataWrapper = [[MetaDataWrapper alloc] init];
        metadata = [[metadataWrapper fetchPList] retain];
        [metadataWrapper release];
        //NSLog(@"in stats: metadata is %@", metadata);
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
    
    // get notification values
    NSDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    //NSLog(@"notificationDict is %@", notificationDict);
    
    
    NSDictionary *allTasksDict = [metadata objectForKey:@"AllTasks"];
    NSDictionary *todayTasksDict = [metadata objectForKey:@"TodayTasks"];
    NSDictionary *historyDict = [metadata objectForKey:@"History"];
    
    notificationsArray = [[NSArray alloc] initWithObjects:[notificationDict objectForKey:@"Total"], [notificationDict objectForKey:@"ActiveAlarms"], [notificationDict objectForKey:@"ActiveReminders"], nil];
    //NSLog(@"notificationsArray is %@", notificationsArray);
    NSString *timeElapsed;
    NSString *timeLeft;
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    
    timeLeft = [formatter stringForCountdownInterval:[allTasksDict objectForKey:@"TimeLeft"]];
    timeElapsed = [formatter stringForCountdownInterval:[allTasksDict objectForKey:@"TimeElapsed"]];
    allTasksArray = [[NSArray alloc] initWithObjects:[allTasksDict objectForKey:@"TotalTasks"], timeLeft, timeElapsed, nil];
    
    timeLeft = [formatter stringForCountdownInterval:[todayTasksDict objectForKey:@"TimeLeft"]];
    timeElapsed = [formatter stringForCountdownInterval:[todayTasksDict objectForKey:@"TimeElapsed"]];
    todayTasksArray = [[NSArray alloc] initWithObjects:[todayTasksDict objectForKey:@"TotalTasks"], [todayTasksDict objectForKey:@"ActiveTasks"], timeLeft, timeElapsed, nil];
    
    timeElapsed = [formatter stringForCountdownInterval:[historyDict objectForKey:@"TimeElapsed"]];
    historyArray = [[NSArray alloc] initWithObjects:[historyDict objectForKey:@"TotalTasks"], timeElapsed, nil];
    
    notificationsKeysArray = [[NSArray alloc] initWithObjects:@"Total", @"Active Alarms", @"Active Reminders", nil];
    allTasksKeysArray = [[NSArray alloc] initWithObjects:@"Total Tasks", @"Time Left", @"Time Elapsed", nil];
    todayTasksKeysArray = [[NSArray alloc] initWithObjects:@"Total Tasks", @"Active Tasks", @"Time Left", @"Time Elapsed", nil];
    historyKeysArray = [[NSArray alloc] initWithObjects:@"Total Tasks", @"Time Elapsed", nil];
    
    [formatter release];
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
    [self.tableView reloadData];
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
            title = @"Notifications";
            break;
        case 1:
            title = @"All Tasks";
            break;
        case 2:
            title = @"Today's Tasks";
            break;
        case 3:
            title = @"History";
            break;
            
        default:
            break;
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = [notificationsArray count];
            break;
        case 1:
            rows = [allTasksArray count];
            break;
        case 2:
            rows = [todayTasksArray count];
            break;
        case 3:
            rows = [historyArray count];
            break;
            
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    NSString *detail;
    //CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = [notificationsKeysArray objectAtIndex:indexPath.row];
            detail = [NSString stringWithFormat:@"%@", [notificationsArray objectAtIndex:indexPath.row]];
            cell.detailTextLabel.text = detail;
            break;
        case 1:
            cell.textLabel.text = [allTasksKeysArray objectAtIndex:indexPath.row];
            detail = [NSString stringWithFormat:@"%@", [allTasksArray objectAtIndex:indexPath.row]];
            cell.detailTextLabel.text = detail;
            break;
        case 2:
            cell.textLabel.text = [todayTasksKeysArray objectAtIndex:indexPath.row];
            detail = [NSString stringWithFormat:@"%@", [todayTasksArray objectAtIndex:indexPath.row]];
            cell.detailTextLabel.text = detail;
            break;
        case 3:
            cell.textLabel.text = [historyKeysArray objectAtIndex:indexPath.row];
            detail = [NSString stringWithFormat:@"%@", [historyArray objectAtIndex:indexPath.row]];
            cell.detailTextLabel.text = detail;
            break;
            
        default:
            break;
    }
                                     
    //[formatter release];
    
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
    [notificationsKeysArray release];
    [allTasksKeysArray release];
    [todayTasksKeysArray release];
    [historyKeysArray release];
    
    [notificationsArray release];
    [allTasksArray release];
    [todayTasksArray release];
    [historyArray release];
    [metadata release];
    [super dealloc];
}

@end
