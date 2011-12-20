//
//  AddViewController.m
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/19/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "AddViewController.h"
#import "TaskInfo.h"

@implementation AddViewController

@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	[super viewDidLoad];
    NSLog(@"addViewController viewDidLoad");
    // Override the DetailViewController viewDidLoad with different navigation bar items and title.
    self.title = @"New Task";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)] autorelease];
    
    self.isNewTask = YES;
	
	// Set up the undo manager and set editing state to YES.
	[self setUpUndoManager];
	self.editing = YES;
}


- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any properties that are loaded in viewDidLoad or can be recreated lazily.
	[self cleanUpUndoManager];	
}


#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)cancel:(id)sender {
	[delegate addViewController:self didFinishWithSave:NO];
}

- (IBAction)save:(id)sender {
	[delegate addViewController:self didFinishWithSave:YES];
    
    //NSLog(@"in addview delegate taskInfo is %@", taskInfo);
    
    NSManagedObjectID *taskID = [taskInfo objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    NSString *urlString = [taskURL absoluteString];
    //NSLog(@"urlString is %@", urlString);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:urlString forKey:@"taskURL"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNewTask" object:nil userInfo:userInfo];
    
    /*
     NSURL *taskURL = [taskID URIRepresentation];
     NSString *urlString = [taskURL absoluteString];
     
     NSLog(@"urlString is %@", urlString);
     */
    
}


@end
