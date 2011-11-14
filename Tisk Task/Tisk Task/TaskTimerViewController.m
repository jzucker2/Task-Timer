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
@synthesize timeElapsedLabel, countdownLabel;

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
    
    editedObject = task;
    
    // display task information
    nameLabel.text = [NSString stringWithFormat:@"Task Name: %@", task.name];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %@", task.duration];
    timeElapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %@", task.elapsed];
    
    if (isRunning == YES) {
        timerButton.titleLabel.text = @"Stop Working";
        
        NSLog(@"set up countdown timer");
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
    //self.taskTimer = nil;
    //[self stopTimer];
    
}

- (void) viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc
{
    //[editedObject release];
    //[task release];
    [timerButton release];
    [nameLabel release];
    [durationLabel release];
    [taskTimer release];
    [timeElapsedLabel release];
    [countdownLabel release];
    [super dealloc];
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
        double elapsed = [task.elapsed doubleValue];
        double duration = [task.duration doubleValue];
        if (elapsed < duration) {
            [self startTimer];
        }
        else
        {
            NSLog(@"duration: %@, elapsed: %@", task.duration, task.elapsed);
            NSLog(@"task is already finished");
        }
        //[self startTimer];
    }
}

- (void) startTimer
{
    NSLog(@"startTimer");
    isRunning = YES;
    //[self updateDatabase];
    
    //timerButton.titleLabel.text = @"Stop Working";
    [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
    
    /*
    NSDate *today;
    today = [NSDate date];
     */
    //NSNumber *timeInterval = task.duration - task.elapsed;
    double duration = [task.duration doubleValue];
    double elapsed = [task.elapsed doubleValue];
    timeLeft = duration - elapsed;
    [self updateDatabase];
    taskTimer = [[NSTimer alloc] init];
    taskTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    
    
}

- (void) stopTimer
{
    NSLog(@"stopTimer");
    isRunning = NO;
    
    [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
    //timerButton.titleLabel.text = @"Start Working";
    [taskTimer invalidate];
    taskTimer = nil;
    [self updateDatabase];
}
                 
- (void) updateCountdownLabel
{
    if (timeLeft>0) {
        countdownLabel.text = [NSString stringWithFormat:@"%f", timeLeft];
        timeLeft--;
    }
    else
    {
        countdownLabel.text = @"Done";
        [taskTimer invalidate];
        taskTimer = nil;
        [self updateDatabase];
    }
}

- (void) updateDatabase
{
    NSUndoManager *undoManager = [[editedObject managedObjectContext] undoManager];
    NSNumber *running;
    if (isRunning== YES) {
        if (timeLeft>0) {
            NSLog(@"time left in task, need to set database to mark task as running");
            [undoManager setActionName:@"running"];
            running = [NSNumber numberWithBool:YES];
            [editedObject setValue:running forKey:@"running"];
            
            NSDate *start = [NSDate date];
            [undoManager setActionName:@"startDate"];
            [editedObject setValue:start forKey:@"startDate"];
            
            NSLog(@"starting, timeLeft is %f", timeLeft);
            NSTimeInterval interval = timeLeft;
            NSDate *end = [NSDate dateWithTimeInterval:interval sinceDate:start];
            
            [undoManager setActionName:@"endDate"];
            [editedObject setValue:end forKey:@"endDate"];
        }
        if (timeLeft == 0) {
            NSLog(@"task finished");
            [undoManager setActionName:@"running"];
            running = [NSNumber numberWithBool:NO];
            [editedObject setValue:running forKey:@"running"];
            
            [undoManager setActionName:@"elapsed"];
            [editedObject setValue:task.duration forKey:@"elapsed"];
            
            [undoManager setActionName:@"completed"];
            NSNumber *completed = [NSNumber numberWithBool:YES];
            [editedObject setValue:completed forKey:@"completed"];
        }
    }
    else
    {
        NSLog(@"task stopped before time ran out");
        [undoManager setActionName:@"running"];
        running = [NSNumber numberWithBool:NO];
        [editedObject setValue:running forKey:@"running"];
        
        [undoManager setActionName:@"elapsed"];
        double duration = [task.duration doubleValue];
        double elapsed = duration - timeLeft;
        NSNumber *elapsedNumber = [NSNumber numberWithDouble:elapsed];
        [editedObject setValue:elapsedNumber forKey:@"elapsed"];
        
    }
    
}

@end
