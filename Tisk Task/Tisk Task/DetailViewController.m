//
//  DetailViewController.m
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "DetailViewController.h"
#import "Task.h"


@implementation DetailViewController

@synthesize task, undoManager;

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


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Configure the title, title bar, and table view.
	self.title = @"Info";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.tableView.allowsSelectionDuringEditing = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    // Redisplay the data.
    [self.tableView reloadData];
	[self updateRightBarButtonItemState];
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
		[self cleanUpUndoManager];
		// Save the changes.
		NSError *error;
		if (![task.managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
		}
	}
}


- (void)viewDidUnload {
	// Release any properties that are loaded in viewDidLoad or can be recreated lazily.
	//self.dateFormatter = nil;
}


- (void)updateRightBarButtonItemState {
	// Conditionally enable the right bar button item -- it should only be enabled if the book is in a valid state for saving.
    self.navigationItem.rightBarButtonItem.enabled = [task validateForUpdate:NULL];
}	


#pragma mark -
#pragma mark Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 1 section
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 3 rows
    return 2;
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
			cell.textLabel.text = @"Name";
			cell.detailTextLabel.text = task.name;
			break;
        case 1: 
			cell.textLabel.text = @"Duration";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", task.duration];
			break;
        /*
        case 2:
			cell.textLabel.text = @"Copyright";
			cell.detailTextLabel.text = [self.dateFormatter stringFromDate:book.copyright];
			break;
         */
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
    NSLog(@"select");
	/*
	if (!self.editing) return;
	
    EditingViewController *controller = [[EditingViewController alloc] initWithNibName:@"EditingView" bundle:nil];
    
    controller.editedObject = task;
    switch (indexPath.row) {
        case 0: {
            controller.editedFieldKey = @"title";
            controller.editedFieldName = NSLocalizedString(@"title", @"display name for title");
            controller.editingDate = NO;
        } break;
        case 1: {
            controller.editedFieldKey = @"author";
			controller.editedFieldName = NSLocalizedString(@"author", @"display name for author");
			controller.editingDate = NO;
        } break;
        
        case 2: {
            controller.editedFieldKey = @"copyright";
			controller.editedFieldName = NSLocalizedString(@"copyright", @"display name for copyright");
			controller.editingDate = YES;
        } break;
         
    }
	
    [self.navigationController pushViewController:controller animated:YES];
	[controller release];
    */
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
	if (task.managedObjectContext.undoManager == nil) {
		
		NSUndoManager *anUndoManager = [[NSUndoManager alloc] init];
		[anUndoManager setLevelsOfUndo:3];
		self.undoManager = anUndoManager;
		[anUndoManager release];
		
		task.managedObjectContext.undoManager = undoManager;
	}
	
	// Register as an observer of the book's context's undo manager.
	//NSUndoManager *bookUndoManager = book.managedObjectContext.undoManager;
    NSUndoManager *taskUndoManager = task.managedObjectContext.undoManager;
	
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc addObserver:self selector:@selector(undoManagerDidUndo:) name:NSUndoManagerDidUndoChangeNotification object:taskUndoManager];
	[dnc addObserver:self selector:@selector(undoManagerDidRedo:) name:NSUndoManagerDidRedoChangeNotification object:taskUndoManager];
}


- (void)cleanUpUndoManager {
	
	// Remove self as an observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	if (task.managedObjectContext.undoManager == undoManager) {
		task.managedObjectContext.undoManager = nil;
		self.undoManager = nil;
	}		
}


- (NSUndoManager *)undoManager {
	return task.managedObjectContext.undoManager;
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

/*
#pragma mark -
#pragma mark Date Formatter

- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	return dateFormatter;
}
 */


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [undoManager release];
    //[dateFormatter release];
    [task release];
    [super dealloc];
}

@end

