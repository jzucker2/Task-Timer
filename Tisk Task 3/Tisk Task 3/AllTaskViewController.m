//
//  AllTaskViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "AllTaskViewController.h"
#import "MetaDataWrapper.h"
#import "CountdownFormatter.h"
#import "NSManagedObjectContext+FetchedObjectFromURI.h"
#import "HelpViewController.h"

@implementation AllTaskViewController

@synthesize managedObjectContext;
@synthesize allTaskTableView;
@synthesize fetchedResultsController;
@synthesize addingManagedObjectContext;
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
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = YES;
    //[self.allTaskTableView deselectRowAtIndexPath:[self.allTaskTableView indexPathForSelectedRow] animated:YES];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
	// Configure the add button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //TaskInfo *taskInfo;
    // add notification for adding a new task
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewTaskToMetadata:) name:@"AddNewTask" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:<#(id)#> selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.allTaskTableView deselectRowAtIndexPath:[self.allTaskTableView indexPathForSelectedRow] animated:YES];
    
    [self updateMetadataLabel];
}

- (void) viewDidAppear:(BOOL)animated
{
    // set that app has sucessfully launched for the first time
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"] ) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"FirstLaunch"];
        // proceed to do what you wish to only on the first launch
        HelpViewController *helpView = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
        [self presentModalViewController:helpView animated:YES];
        [helpView release];
        /*
         UIAlertView *enableAlert = [[UIAlertView alloc] initWithTitle:@"Please enable notifications" message:@"In order for this app to work, please enable notifications, and set them to type 'Alerts'" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [enableAlert show];
         [enableAlert release];
         */
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.fetchedResultsController = nil;
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
    NSMutableDictionary *allTasksDict = [metadata objectForKey:@"AllTasks"];
    
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    
    
    NSString *timeSpent = [formatter stringForCountdownInterval:[allTasksDict objectForKey:@"TimeElapsed"]];
    NSString *timeLeft = [formatter stringForCountdownInterval:[allTasksDict objectForKey:@"TimeLeft"]];
    
    [formatter release];
    
    [metadataWrapper release];
    
    metadataLabel.text = [NSString stringWithFormat:@"Spent:%@   Left:%@", timeSpent, timeLeft];
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
    //return 0;
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
    
    //return 1;
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
    // Configure the cell to show the book's title
	TaskInfo *taskInfo = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = taskInfo.title;
    
    BOOL todayBOOL = [taskInfo.isToday boolValue];
    
    UISwitch *todaySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    if (todayBOOL == YES) {
        [todaySwitch setOn:YES];
    }
    else
    {
        [todaySwitch setOn:NO];
    }
    [todaySwitch addTarget:self action:@selector(todaySwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    todaySwitch.tag = indexPath.row;
    cell.accessoryView = todaySwitch;
    [todaySwitch release];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		// Delete the managed object.
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
        
        TaskInfo *taskInfo = (TaskInfo *)[fetchedResultsController objectAtIndexPath:indexPath];
        MetaDataWrapper *metadata = [[MetaDataWrapper alloc] init];
        [metadata deleteTask:taskInfo];
        [metadata release];
        [self updateMetadataLabel];
        
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		NSError *error;
		if (![context save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
		}
    }
    /*
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }   
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     */
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selected row");
    // Create and push a detail view controller.
	DetailViewController *detailViewController = [[DetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    TaskInfo *selectedInfo = (TaskInfo *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    // Pass the selected book to the new view controller.
    detailViewController.taskInfo = selectedInfo;
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
    
}

#pragma mark -
#pragma mark Adding a Task

/**
 Creates a new book, an AddViewController to manage addition of the book, and a new managed object context for the add controller to keep changes made to the book discrete from the application's managed object context until the book is saved.
 IMPORTANT: It's not necessary to use a second context for this. You could just use the existing context, which would simplify some of the code -- you wouldn't need to merge changes after a save, for example. This implementation, though, illustrates a pattern that may sometimes be useful (where you want to maintain a separate set of edits).  The root view controller sets itself as the delegate of the add controller so that it can be informed when the user has completed the add operation -- either saving or canceling (see addViewController:didFinishWithSave:).
 */
- (IBAction)addTask {
	
    AddViewController *addViewController = [[AddViewController alloc] initWithStyle:UITableViewStyleGrouped];
	addViewController.delegate = self;
	
	// Create a new managed object context for the new book -- set its persistent store coordinator to the same as that from the fetched results controller's context.
	NSManagedObjectContext *addingContext = [[NSManagedObjectContext alloc] init];
	self.addingManagedObjectContext = addingContext;
	[addingContext release];
	
	[addingManagedObjectContext setPersistentStoreCoordinator:[[fetchedResultsController managedObjectContext] persistentStoreCoordinator]];
    
	addViewController.taskInfo = (TaskInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"TaskInfo" inManagedObjectContext:addingContext];
    
    NSDate *today = [NSDate date];
    [addViewController.taskInfo setValue:today forKey:@"creationDate"];
    NSNumber *noBOOL = [NSNumber numberWithBool:NO];
    [addViewController.taskInfo setValue:noBOOL forKey:@"isCompleted"];
    
    
    
    /*
     NSManagedObject *taskDetails = [NSEntityDescription insertNewObjectForEntityForName:@"TaskDetails" inManagedObjectContext:addingContext];
     [taskDetails setValue:@"blah" forKey:@"specifics"];
     
     [taskDetails setValue:addViewController.taskInfo forKey:@"info"];
     [addViewController.taskInfo setValue:taskDetails forKey:@"details"];
     */
    
    //[addViewController.taskInfo setValue:<#(id)#> forKey:<#(NSString *)#>
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
	
    [self.navigationController presentModalViewController:navController animated:YES];
	
	[addViewController release];
	[navController release];
}



/**
 Add controller's delegate method; informs the delegate that the add operation has completed, and indicates whether the user saved the new book.
 */

- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save {
	
	if (save) {
		/*
		 The new book is associated with the add controller's managed object context.
		 This is good because it means that any edits that are made don't affect the application's main managed object context -- it's a way of keeping disjoint edits in a separate scratchpad -- but it does make it more difficult to get the new book registered with the fetched results controller.
		 First, you have to save the new book.  This means it will be added to the persistent store.  Then you can retrieve a corresponding managed object into the application delegate's context.  Normally you might do this using a fetch or using objectWithID: -- for example
		 
		 NSManagedObjectID *newBookID = [controller.book objectID];
		 NSManagedObject *newBook = [applicationContext objectWithID:newBookID];
		 
		 These techniques, though, won't update the fetch results controller, which only observes change notifications in its context.
		 You don't want to tell the fetch result controller to perform its fetch again because this is an expensive operation.
		 You can, though, update the main context using mergeChangesFromContextDidSaveNotification: which will emit change notifications that the fetch results controller will observe.
		 To do this:
		 1	Register as an observer of the add controller's change notifications
		 2	Perform the save
		 3	In the notification method (addControllerContextDidSave:), merge the changes
		 4	Unregister as an observer
		 */
        
        // package into dictionary
        
		NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(addControllerContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:addingManagedObjectContext];
        
        
        
        // add notification for taskInfo to update metadata
        //NSNotificationCenter *
		
		NSError *error;
		if (![addingManagedObjectContext save:&error]) 
        {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
		}
		[dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:addingManagedObjectContext];
	}
    
    
    

    
    
	// Release the adding managed object context.
	self.addingManagedObjectContext = nil;
    
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
}





/**
 Notification from the add controller's context's save operation. This is used to update the fetched results controller's managed object context with the new book instead of performing a fetch (which would be a much more computationally expensive operation).
 */
- (void)addControllerContextDidSave:(NSNotification*)saveNotification {
    
    /*
    NSMutableDictionary *userInfo = (NSMutableDictionary *)[saveNotification userInfo];
    NSLog(@"userInfo is %@", userInfo);
    // need to add task to metadata
    NSMutableDictionary *inserted = (NSMutableDictionary *)[userInfo objectForKey:@"inserted"];
    NSManagedObjectID *taskID  = (NSManagedObjectID *)[inserted objectForKey:@"id"];
    NSString *taskIDString = [userInfo objectForKey:@"id"];
    NSLog(@"taskID is %@", taskID);
    NSLog(@"taskIDString is %@", taskIDString);
    //NSURL *taskURL = [taskID URIRepresentation];
    
    TaskInfo *taskInfo = (TaskInfo *)[managedObjectContext objectWithID:taskID];
    NSLog(@"taskInfo is %@", taskInfo);
    
    // need to ask task to metadata
    MetaDataWrapper *metadata = [[MetaDataWrapper alloc] init];
    [metadata addNewTask:taskInfo];
    [metadata release];
     */
    
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	// Merging changes causes the fetched results controller to update its results
	[context mergeChangesFromContextDidSaveNotification:saveNotification];	
}

- (void) addNewTaskToMetadata:(NSNotification *)notification
{
    //NSLog(@"notification is %@", notification);
    NSString *taskURLString = [notification.userInfo objectForKey:@"taskURL"];
    NSURL *taskURL = [NSURL URLWithString:taskURLString];
    
    TaskInfo *taskInfo = (TaskInfo *) [managedObjectContext objectWithURI:taskURL];
    //NSLog(@"taskInfo is %@", taskInfo);
    
    // need to add task to metadata
    MetaDataWrapper *metadata = [[MetaDataWrapper alloc] init];
    [metadata addNewTask:taskInfo];
    [metadata release];
    
    [self updateMetadataLabel];
    
    
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
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isCompleted == %@", [NSNumber numberWithBool:NO]];
    [fetchRequest setPredicate:predicate];
     
    
	
	// Create the sort descriptors array.
	//NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"author" ascending:YES];
	NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:titleDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"All"];
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
	[self.allTaskTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	UITableView *tableView = self.allTaskTableView;
    
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
			[self.allTaskTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.allTaskTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.allTaskTableView endUpdates];
}

#pragma mark -
#pragma mark Today Switch
- (IBAction)todaySwitchValueChanged:(id)sender
{
    //NSLog(@"today switch value changed");
    UITableViewCell *cell = (UITableViewCell *) [sender superview];
    NSIndexPath *switchIndexPath = [self.allTaskTableView indexPathForCell:cell];
    
    //[self.tableView indexPathForCell:<#(UITableViewCell *)#>
    TaskInfo *selectedInfo = (TaskInfo *)[[self fetchedResultsController] objectAtIndexPath:switchIndexPath];
    //NSLog(@"selectedInfo is %@", selectedInfo);
    //NSLog(@"title is %@", selectedInfo.title);
    
    
    //NSNumber *newToday;
    BOOL oldToday = [selectedInfo.isToday boolValue];
    BOOL newToday;
    if (oldToday == YES) {
        //newToday = [NSNumber numberWithBool:NO];
        //[self cancelReminder:selectedInfo];
        newToday = NO;
    }
    else
    {
        newToday = YES;
        //newToday = [NSNumber numberWithBool:YES];
        //[self scheduleReminder:selectedInfo];
    }
    
    [selectedInfo changeToday:newToday];
    //[selectedInfo setValue:newToday forKey:@"isToday"];
    
    
    
    
    /*
    NSError *error;
    if (![managedObjectContext save:&error]) 
    {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
     */
    
    //NSLog(@"selectedInfo is now %@", selectedInfo);
    
    
    
    /*
     NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
     [dnc addObserver:self selector:@selector(addControllerContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:selectedInfo];
     
     NSError *error;
     if (![selectedInfo save:&error]) 
     {
     // Update to handle the error appropriately.
     NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
     exit(-1);  // Fail
     }
     [dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:selectedInfo];
     */
    
}


#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [metadataLabel release];
    [addingManagedObjectContext release];
    [fetchedResultsController release];
    [allTaskTableView release];
    [managedObjectContext release];
    [super dealloc];
}

@end
