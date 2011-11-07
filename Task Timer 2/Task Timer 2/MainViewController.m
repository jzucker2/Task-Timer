//
//  MainViewController.m
//  Task Timer 2
//
//  Created by Jordan Zucker on 11/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize allTasksButton;
@synthesize todayButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [_managedObjectContext release];
    [super dealloc];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

#pragma mark - View Changes

- (IBAction) showAllTasks:(id)sender
{
    //AllTasksViewController *taskView = [[AllTasksViewController alloc] initWithNibName:@"AllTasksView" bundle:[NSBundle mainBundle]];
    EveryTaskViewController *everyTask = [[EveryTaskViewController alloc] initWithNibName:@"EveryTaskView" bundle:nil];
    everyTask.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:everyTask animated:YES];
    [everyTask release];
}

- (IBAction)showToday:(id)sender
{
    NSLog(@"today's tasks");
}

@end
