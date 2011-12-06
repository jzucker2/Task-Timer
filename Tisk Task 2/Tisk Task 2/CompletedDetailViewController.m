//
//  CompletedDetailViewController.m
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/5/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "CompletedDetailViewController.h"

@implementation CompletedDetailViewController

@synthesize taskInfo;

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
    self.title = @"Task Info";
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    // Configure the cell...
    
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Title";
            cell.detailTextLabel.text = taskInfo.title;
            break;
        case 1:
            cell.textLabel.text = @"Duration";
            NSString *durationString = [formatter stringForCountdownInterval:taskInfo.duration];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", durationString];
            break;
        case 2:
            cell.textLabel.text = @"Elapsed";
            NSString *elapsedString = [formatter stringForCountdownInterval:taskInfo.elapsedTime];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", elapsedString];
            break;
        case 3:
            cell.textLabel.text = @"Completion Date";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.completionDate];
            break;
        case 4:
            cell.textLabel.text = @"isCompleted";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.isCompleted];
            break;
        case 5:
            cell.textLabel.text = @"isRunning";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.isRunning];
            break;
        case 6:
            cell.textLabel.text = @"isRepeating";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.isRepeating];
            break;
        case 7:
            cell.textLabel.text = @"isToday";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.isToday];
            break;
        case 8:
            cell.textLabel.text = @"Creation Date";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.creationDate];
            break;
        case 9:
            cell.textLabel.text = @"Start Time";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.startTime];
            break;
        case 10:
            cell.textLabel.text = @"Projected End Time";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", taskInfo.projectedEndTime];
            break;
            
        default:
            break;
    }
    
    [formatter release];
    
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

- (void) dealloc
{
    [taskInfo release];
    [super dealloc];
}

@end
