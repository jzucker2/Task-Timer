//
//  EditingViewController.m
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "EditingViewController.h"

@implementation EditingViewController

@synthesize textField, editedObject, editedFieldKey, editedFieldName, editingTime, durationPicker;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	// Set the title to the user-visible name of the field.
	self.title = editedFieldName;
    
	// Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// Configure the user interface according to state.
    if (editingTime) {
        textField.hidden = YES;
        durationPicker.hidden = NO;
        /*
		NSDate *date = [editedObject valueForKey:editedFieldKey];
        if (date == nil) date = [NSDate date];
        datePicker.date = date;
         */
    }
	else {
        //NSLog(@"need to hide duration picker");
        textField.hidden = NO;
        //durationPicker.hidden = YES;
        [durationPicker setHidden:YES];
        textField.text = [editedObject valueForKey:editedFieldKey];
		textField.placeholder = self.title;
        [textField becomeFirstResponder];
    }
}


#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)save {
	
	// Set the action name for the undo operation.
	NSUndoManager * undoManager = [[editedObject managedObjectContext] undoManager];
	[undoManager setActionName:[NSString stringWithFormat:@"%@", editedFieldName]];
	
    // Pass current value to the edited object, then pop.
    if (editingTime) {
        NSLog(@"duration is %f", durationPicker.countDownDuration);
        NSNumber *duration = [NSNumber numberWithDouble:durationPicker.countDownDuration];
        //[editedObject setValue:durationPicker.countDownDuration forKey:editedFieldKey];
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
    [durationPicker release];
	[super dealloc];
}


@end