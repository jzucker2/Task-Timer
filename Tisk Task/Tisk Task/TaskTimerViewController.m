//
//  TaskTimerViewController.m
//  Tisk Task
//
//  Created by Jordan Zucker on 11/8/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TaskTimerViewController.h"

@implementation TaskTimerViewController

@synthesize task;
@synthesize nameLabel, durationLabel, timerButton;
@synthesize editedObject;
@synthesize taskTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isRunning = [task.running boolValue];
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
    
    // display task information
    nameLabel.text = [NSString stringWithFormat:@"Task Name: %@", task.name];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %@", task.duration];
    
    if (isRunning == YES) {
        timerButton.titleLabel.text = @"Stop Working";
    }
    else
    {
        timerButton.titleLabel.text = @"Start Working";
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

#pragma mark - Timer

- (IBAction)handleTimer:(id)sender
{
    //NSLog(@"start or stop timer");
    if (isRunning == YES) {
        [self stopTimer];
    }
    else
    {
        [self startTimer];
    }
}

- (void) startTimer
{
    NSLog(@"startTimer");
}

- (void) stopTimer
{
    NSLog(@"stopTimer");
}

@end
