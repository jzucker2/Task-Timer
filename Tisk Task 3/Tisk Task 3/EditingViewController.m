//
//  EditingViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "EditingViewController.h"
#import "MetaDataWrapper.h"
#import "TaskInfo.h"


@implementation EditingViewController

@synthesize textField, editedObject, editedFieldKey, editedFieldName, editingDuration, datePicker, editingSpecifics, textView;

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
    
    [textView setDelegate:self];
    NSLog(@"end of viewDidLoad");
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear start");
    // Configure the user interface according to state.
    
    if (editingDuration) 
    {
        NSLog(@"EditingDuration");
        textField.hidden = YES;
        datePicker.hidden = NO;
        textView.hidden = YES;
        /*
         if ([editedObject valueForKey:editedFieldKey) {
         <#statements#>
         }
         */
        double countdown = [[editedObject valueForKey:editedFieldKey] doubleValue];
        [datePicker setCountDownDuration:countdown];
        
    }
    if (editingSpecifics) {
        NSLog(@"editingSpecifics");
        textField.hidden = YES;
        datePicker.hidden = YES;
        textView.hidden = NO;
        [textView setText:[editedObject valueForKey:editedFieldKey]];
        
    }
	if ((editingSpecifics == NO) && (editingDuration == NO)) {
        NSLog(@"editing text field");
        textView.hidden = YES;
        textField.hidden = NO;
        datePicker.hidden = YES;
        textField.text = [editedObject valueForKey:editedFieldKey];
		textField.placeholder = self.title;
        [textField becomeFirstResponder];
    }
    else
    {
        NSLog(@"error");
        
    }
    NSLog(@"viewWillAppear end");
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
        NSNumber *newDuration = [NSNumber numberWithDouble:datePicker.countDownDuration];
        TaskInfo *taskInfo = (TaskInfo *) editedObject;
        double oldDuration = [taskInfo.duration doubleValue];
        
        [editedObject setValue:newDuration forKey:editedFieldKey];
        // need to update metadata here!!!!        
        MetaDataWrapper *metadata = [[MetaDataWrapper alloc] init];
        [metadata editTask:taskInfo withOldDuration:oldDuration];
        [metadata release];
        
        //NSMutableDictionary *metadata = 
    }
    if (editingSpecifics) {
        [editedObject setValue:textView.text forKey:editedFieldKey];
    }
	if ((editingDuration == NO) && (editingSpecifics == NO)) {
        [editedObject setValue:textField.text forKey:editedFieldKey];
    } 
    else
    {
        NSLog(@"error");
    }
	
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancel {
    // Don't pass current value to the edited object, just pop.
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void) textViewDidChange:(UITextView *)textView
{
    
}

- (void) textViewDidChangeSelection:(UITextView *)textView
{
    
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [textView release];
    [textField release];
    [editedObject release];
    [editedFieldKey release];
    [editedFieldName release];
    [datePicker release];
	[super dealloc];
}

@end