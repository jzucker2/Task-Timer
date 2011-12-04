//
//  EditingViewController.m
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/1/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "EditingViewController.h"

@implementation EditingViewController

@synthesize textField, editedObject, editedFieldKey, editedFieldName, editingDuration, datePicker;

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
    self.title = editedFieldName;
    
    // Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Configure the user interface according to state.
    if (editingDuration) 
    {
        textField.hidden = YES;
        datePicker.hidden = NO;
        
    }
	else 
    {
        textField.hidden = NO;
        datePicker.hidden = YES;
        textField.text = [editedObject valueForKey:editedFieldKey];
		textField.placeholder = self.title;
        [textField becomeFirstResponder];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)save 
{
	
	// Set the action name for the undo operation.
	NSUndoManager * undoManager = [[editedObject managedObjectContext] undoManager];
    NSLog(@"editedFieldName is %@", editedFieldName);
	[undoManager setActionName:[NSString stringWithFormat:@"%@", editedFieldName]];
	
    // Pass current value to the edited object, then pop.
    if (editingDuration) 
    {
        NSNumber *duration = [NSNumber numberWithDouble:datePicker.countDownDuration];
        [editedObject setValue:duration forKey:editedFieldKey];
    }
	else {
        [editedObject setValue:textField.text forKey:editedFieldKey];
    }
	
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancel {
    // Don't pass current value to the edited object, just pop.
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [textField release];
    [editedObject release];
    [editedFieldKey release];
    [editedFieldName release];
    [datePicker release];
	[super dealloc];
}

@end
