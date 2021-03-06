//
//  TodayTaskViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TodayTaskViewController.h"
#import "MetaDataWrapper.h"
#import "CountdownFormatter.h"

@implementation TodayTaskViewController

@synthesize managedObjectContext;
@synthesize todayTableView, fetchedResultsController;
@synthesize metadataLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.fetchedResultsController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.todayTableView reloadData];
    
    [self.todayTableView deselectRowAtIndexPath:[self.todayTableView indexPathForSelectedRow] animated:YES];
    
    [self updateMetadataLabel];
    
    /*
    MetaDataWrapper *metadataWrapper = [[MetaDataWrapper alloc] init];
    NSMutableDictionary *metadata = [metadataWrapper fetchPList];
    NSMutableDictionary *todayDict = [metadata objectForKey:@"TodayTasks"];
    
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    
    
    NSString *timeSpent = [formatter stringForCountdownInterval:[todayDict objectForKey:@"TimeElapsed"]];
    NSString *timeLeft = [formatter stringForCountdownInterval:[todayDict objectForKey:@"TimeLeft"]];
    
    [formatter release];
    
    [metadataWrapper release];
    
    metadataLabel.text = [NSString stringWithFormat:@"Spent:%@   Left:%@", timeSpent, timeLeft];
     */
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Metadata Label

- (void) updateMetadataLabel
{
    MetaDataWrapper *metadataWrapper = [[MetaDataWrapper alloc] init];
    NSMutableDictionary *metadata = [metadataWrapper fetchPList];
    NSMutableDictionary *todayDict = [metadata objectForKey:@"TodayTasks"];
    
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    
    
    NSString *timeSpent = [formatter stringForCountdownInterval:[todayDict objectForKey:@"TimeElapsed"]];
    NSString *timeLeft = [formatter stringForCountdownInterval:[todayDict objectForKey:@"TimeLeft"]];
    
    [formatter release];
    
    [metadataWrapper release];
    
    metadataLabel.text = [NSString stringWithFormat:@"Spent:%@   Left:%@", timeSpent, timeLeft];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 0;
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //UIImageView *imageView = [[UIImageView alloc] init];
    UIImageView *imageView = [cell imageView];
    TaskInfo *taskInfo = [fetchedResultsController objectAtIndexPath:indexPath];
    BOOL running = [taskInfo.isRunning boolValue];
    if (running == YES) {
        //[imageView setBackgroundColor:[UIColor greenColor]];
        [imageView setImage:[UIImage imageNamed:@"Signal_Light_-_Green.jpg"]];
    }
    else
    {
        [imageView setImage:[UIImage imageNamed:@"redlight.jpg"]];
    }
    cell.textLabel.text = taskInfo.title;
    
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selected row");
    
    TaskTimerViewController *taskTimerViewController = [[TaskTimerViewController alloc] initWithNibName:@"TaskTimerView" bundle:nil];
    TaskInfo *selectedInfo = (TaskInfo *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    // pass selected object to new view controller
    taskTimerViewController.taskInfo = selectedInfo;
    taskTimerViewController.title = selectedInfo.title;
    [self.navigationController pushViewController:taskTimerViewController animated:YES];
    [taskTimerViewController release];
    
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
#pragma mark Fetched results controller

/**
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
	// Create and configure a fetch request with the Book entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"TaskInfo" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isToday == %@) AND (isCompleted == %@)", [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isToday == %@)", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
    //NSPredicate *predicate = [NSPredicate pre
	
	// Create the sort descriptors array.
	NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
	//NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"duration" ascending:YES];
    //NSSortDescriptor *currentDescriptor = [[NSSortDescriptor alloc] initWithKey:@"current" ascending:YES];
	//NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, titleDescriptor, currentDescriptor, nil];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:titleDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
    /*
     NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"name" cacheName:@"Root"];
     */
    //NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"current" cacheName:@"Root"];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Today"];
	self.fetchedResultsController = aFetchedResultsController;
	fetchedResultsController.delegate = self;
	
	// Memory management.
	[aFetchedResultsController release];
	[fetchRequest release];
	//[authorDescriptor release];
	[titleDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.todayTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	UITableView *tableView = self.todayTableView;
    
	switch(type) {
			
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
	switch(type) {
			
		case NSFetchedResultsChangeInsert:
			[self.todayTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.todayTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.todayTableView endUpdates];
    //[self updateMetadataLabel];
}



#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [fetchedResultsController release];
    [todayTableView release];
    [managedObjectContext release];
    [super dealloc];
}

@end
