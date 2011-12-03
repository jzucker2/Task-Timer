//
//  TaskTimerViewController.m
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/2/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TaskTimerViewController.h"

@implementation TaskTimerViewController

@synthesize taskInfo, countdownTimer, timerButton, titleLabel, durationLabel, countdownLabel;
@synthesize elapsedLabel;

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
    
    titleLabel.text = taskInfo.title;
    double duration = [taskInfo.duration doubleValue];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %f", duration];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    elapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %f", elapsed];
    //timeLeft = ;
    //NSLog(@"timeLeft is %f", timeLeft);
    countdownTimer = [[NSTimer alloc] init];
    //taskTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    //countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    
    BOOL running = [taskInfo.isRunning boolValue];
    if (running == YES) 
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
    }
    else
    {
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        
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
    [countdownTimer invalidate];
    countdownTimer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Timer Action

- (IBAction)timerButtonAction:(id)sender
{
    NSLog(@"timerButton");
    BOOL runningBOOL = [taskInfo.isRunning boolValue];
    
    if (runningBOOL == YES) {
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        [self stopTimer];
    }
    else
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
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

- (void) updateCountdownLabel
{
    NSLog(@"updateCountdownLabel");
    countdownLabel.text = [NSString stringWithFormat:@"%f", timeLeft];
    timeLeft--;
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [titleLabel release];
    [durationLabel release];
    [countdownTimer release];
    [countdownLabel release];
    
    [super dealloc];
}

@end
