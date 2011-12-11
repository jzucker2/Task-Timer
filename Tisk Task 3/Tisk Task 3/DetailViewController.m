//
//  DetailViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "DetailViewController.h"
#import "TaskInfo.h"
#import "EditingViewController.h"


@implementation DetailViewController

@synthesize taskInfo, undoManager;
@synthesize todaySwitch;

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    NSLog(@"taskInfo is %@", taskInfo);
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
    
    // Redisplay data
    [self.tableView reloadData];
    [self updateRightBarButtonItemState];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
	
	// Hide the back button when editing starts, and show it again when editing finishes.
    [self.navigationItem setHidesBackButton:editing animated:animated];
    [self.tableView reloadData];
	
	/*
	 When editing starts, create and set an undo manager to track edits. Then register as an observer of undo manager change notifications, so that if an undo or redo operation is performed, the table view can be reloaded.
	 When editing ends, de-register from the notification center and remove the undo manager, and save the changes.
	 */
	if (editing) {
		[self setUpUndoManager];
	}
	else {
        //NSLog(@"save changes");
		[self cleanUpUndoManager];
		// Save the changes.
		NSError *error;
		if (![taskInfo.managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
		}
	}
}

- (void) updateRightBarButtonItemState
{
    // Conditionally enable the right bar button item -- it should only be enabled if the book is in a valid state for saving.
    self.navigationItem.rightBarButtonItem.enabled = [taskInfo validateForUpdate:NULL];
}


#pragma mark -
#pragma mark Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 1 section
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 4 rows
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
    
    
	switch (indexPath.row) {
        case 0: 
			cell.textLabel.text = @"Title";
			cell.detailTextLabel.text = taskInfo.title;
			break;
        case 1: 
			cell.textLabel.text = @"Duration";
            CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
            NSString *duration = [formatter stringForCountdownInterval:taskInfo.duration];
            //NSString *duration = [NSString stringWithFormat:@"%@", taskInfo.duration];
			cell.detailTextLabel.text = duration;
			break;
        case 2:
			cell.textLabel.text = @"Is Today";
            NSString *isToday = [NSString stringWithFormat:@"%@", taskInfo.isToday];
			cell.detailTextLabel.text = isToday;
            todaySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            //[todaySwitch addTarget:self action:@selector(todaySwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = todaySwitch;
            
            BOOL isTodayBOOL = [taskInfo.isToday boolValue];
            if (isTodayBOOL == YES) {
                [todaySwitch setOn:YES];
            }
            else
            {
                [todaySwitch setOn:NO];
            }
            
            [todaySwitch addTarget:self action:@selector(todaySwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
            
            
            
            
			break;
        case 3:
            cell.textLabel.text = @"Is Running";
            NSString *isRunning = [NSString stringWithFormat:@"%@", taskInfo.isRunning];
			cell.detailTextLabel.text = isRunning;
			break;
        case 4:
            cell.textLabel.text = @"Specifics";
            cell.detailTextLabel.text = taskInfo.specifics;
            break;
    }
    
    
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow selection if editing.
    return (self.editing) ? indexPath : nil;
}

/**
 Manage row selection: If a row is selected, create a new editing view controller to edit the property associated with the selected row.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (!self.editing) return;
	
    EditingViewController *controller = [[EditingViewController alloc] initWithNibName:@"EditingView" bundle:nil];
    
    controller.editedObject = taskInfo;
    switch (indexPath.row) {
        case 0: {
            NSLog(@"title");
            controller.editedFieldKey = @"title";
            //controller.editedFieldName = NSLocalizedString(@"title", @"display name for title");
            controller.editedFieldName = @"title";
            controller.editingDuration = NO;
            controller.editingSpecifics = NO;
            [self.navigationController pushViewController:controller animated:YES];
        } break;
        case 1: {
            NSLog(@"duration");
            controller.editedFieldKey = @"duration";
            //controller.editedFieldName = NSLocalizedString(@"duration", @"display name for author");
            controller.editedFieldName = @"duration";
            controller.editingDuration = YES;
            controller.editingSpecifics = NO;
            controller.editingExistingObject = YES;
            [self.navigationController pushViewController:controller animated:YES];
        } break;
        case 4: {
            NSLog(@"specifics");
            controller.editedFieldKey = @"specifics";
            controller.editedFieldName = @"specifics";
            controller.editingDuration = NO;
            controller.editingSpecifics = YES;
            [self.navigationController pushViewController:controller animated:YES];
        } break;
        default: {
            NSLog(@"uneditable");
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        } break;
    }
	[controller release];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}


#pragma mark -
#pragma mark Undo support

- (void)setUpUndoManager {
	/*
	 If the book's managed object context doesn't already have an undo manager, then create one and set it for the context and self.
	 The view controller needs to keep a reference to the undo manager it creates so that it can determine whether to remove the undo manager when editing finishes.
	 */
	if (taskInfo.managedObjectContext.undoManager == nil) {
		
		NSUndoManager *anUndoManager = [[NSUndoManager alloc] init];
		[anUndoManager setLevelsOfUndo:4];
		self.undoManager = anUndoManager;
		[anUndoManager release];
		
		taskInfo.managedObjectContext.undoManager = undoManager;
	}
	
	// Register as an observer of the book's context's undo manager.
	NSUndoManager *taskUndoManager = taskInfo.managedObjectContext.undoManager;
	
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc addObserver:self selector:@selector(undoManagerDidUndo:) name:NSUndoManagerDidUndoChangeNotification object:taskUndoManager];
	[dnc addObserver:self selector:@selector(undoManagerDidRedo:) name:NSUndoManagerDidRedoChangeNotification object:taskUndoManager];
}


- (void)cleanUpUndoManager {
	
	// Remove self as an observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	if (taskInfo.managedObjectContext.undoManager == undoManager) {
		taskInfo.managedObjectContext.undoManager = nil;
		self.undoManager = nil;
	}		
}


- (NSUndoManager *)undoManager {
	return taskInfo.managedObjectContext.undoManager;
}


- (void)undoManagerDidUndo:(NSNotification *)notification {
	[self.tableView reloadData];
	[self updateRightBarButtonItemState];
}


- (void)undoManagerDidRedo:(NSNotification *)notification {
	[self.tableView reloadData];
	[self updateRightBarButtonItemState];
}


/*
 The view controller must be first responder in order to be able to receive shake events for undo. It should resign first responder status when it disappears.
 */
- (BOOL)canBecomeFirstResponder {
	return YES;
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self resignFirstResponder];
}

#pragma mark -
#pragma mark Today Switch

- (IBAction)todaySwitchValueChanged:(id)sender
{
    //NSLog(@"today switch tapped");
    
    /*
    NSNumber *currentNumber;
    if (todaySwitch.isOn) {
        currentNumber = [NSNumber numberWithBool:YES];
    }
    else
    {
        currentNumber = [NSNumber numberWithBool:NO];
    }
     */
    
    //[taskInfo setValue:currentNumber forKey:@"isToday"];
    [taskInfo changeToday:todaySwitch.isOn];
    
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [undoManager release];
    [taskInfo release];
    [todaySwitch release];
    [super dealloc];
}


@end
