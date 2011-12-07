//
//  TaskTimerViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TaskTimerViewController.h"

@implementation TaskTimerViewController

@synthesize taskInfo, countdownTimer, timerButton, titleLabel, durationLabel, countdownLabel;
@synthesize elapsedLabel;
@synthesize specificsView;
@synthesize finishEarlyButton;
@synthesize timerFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        timerFormatter = [[CountdownFormatter alloc] init];
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
    
    [super viewDidLoad];
    //NSLog(@"viewDidLoad");
    NSLog(@"taskInfo is %@", taskInfo);
    [specificsView setDelegate:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    countdownTimer = [[NSTimer alloc] init];
    
    titleLabel.text = taskInfo.title;
    //double duration = [taskInfo.duration doubleValue];
    
    NSLog(@"first use countdownformatter");
    CountdownFormatter *formatter = [[CountdownFormatter alloc] init];
    NSString *durationString = [formatter stringForCountdownInterval:taskInfo.duration];
    NSString *elapsedString = [formatter stringForCountdownInterval:taskInfo.elapsedTime];
    
    //durationString = [NSString stringWithFormat:@"Duration: %@", durationString];
    //elapsedString = [NSString stringWithFormat:@"Elapsed: %@", elapsedString];
    
    [formatter release];
    
    durationLabel.text = [NSString stringWithFormat:@"Duration: %@", durationString];
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    elapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %@", elapsedString];
    specificsView.text = taskInfo.specifics;
    
    BOOL running = [taskInfo.isRunning boolValue];
    if (running == YES) 
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
        [finishEarlyButton setEnabled:YES];
        [self continueTimer];
        
    }
    else
    {
        [finishEarlyButton setEnabled:NO];
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        //timeLeft = duration - elapsed;
        
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [countdownTimer invalidate];
    countdownTimer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Timer Button Actions

- (IBAction)timerButtonAction:(id)sender
{
    //NSLog(@"timerButton");
    BOOL runningBOOL = [taskInfo.isRunning boolValue];
    
    if (runningBOOL == YES) {
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        //NSLog(@"timer button hit, call stop timer");
        [self stopTimer];
        [finishEarlyButton setEnabled:NO];
    }
    else
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
        //NSLog(@"timer button hit, call start timer");
        [self startTimer];
        [finishEarlyButton setEnabled:YES];
    }
}

- (IBAction)finishEarlyAction:(id)sender
{
    [self finishTimer];
}

#pragma mark -
#pragma mark Timer Delegate

- (void) startTimer
{
    
}

- (void) continueTimer
{
    
}

- (void) stopTimer
{
    
}

- (void) finishTimer
{
    
}

- (void) endTimer
{
    
}

#pragma mark -
#pragma mark CountdownLabel

- (void) updateCountdownLabel
{
    NSNumber *timeLeftNumber = [NSNumber numberWithDouble:timeLeft];
    NSString *countdownString = [timerFormatter stringForCountdownInterval:timeLeftNumber];
    
    //countdownLabel.text = [NSString stringWithFormat:@"%f", timeLeft];
    countdownLabel.text = [NSString stringWithFormat:@"%@", countdownString];
    if (timeLeft >0) {
        timeLeft--;
    }
    else
    {
        NSLog(@"end task");
        [self endTimer];
    }
}


#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [timerFormatter release];
    [titleLabel release];
    [durationLabel release];
    [elapsedLabel release];
    [countdownTimer release];
    [countdownLabel release];
    [taskInfo release];
    
    [super dealloc];
}

@end
