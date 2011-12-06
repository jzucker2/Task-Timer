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
@synthesize specificsView;
@synthesize finishEarlyButton;

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
    //NSLog(@"viewDidLoad");
    NSLog(@"taskInfo is %@", taskInfo);
    [specificsView setDelegate:self];
    // Do any additional setup after loading the view from its nib.
    
    /*
    titleLabel.text = taskInfo.title;
    double duration = [taskInfo.duration doubleValue];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %f", duration];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    elapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %f", elapsed];
     */
    //timeLeft = ;
    //NSLog(@"timeLeft is %f", timeLeft);
    //countdownTimer = [[NSTimer alloc] init];
    //taskTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    //countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    
    /*
    BOOL running = [taskInfo.isRunning boolValue];
    if (running == YES) 
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
        
    }
    else
    {
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        timeLeft = duration - elapsed;
        
    }
     */
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    countdownTimer = [[NSTimer alloc] init];
    
    titleLabel.text = taskInfo.title;
    double duration = [taskInfo.duration doubleValue];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %f", duration];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    elapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %f", elapsed];
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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    //NSLog(@"viewDidAppear");
    countdownTimer = [[NSTimer alloc] init];
    
    titleLabel.text = taskInfo.title;
    double duration = [taskInfo.duration doubleValue];
    durationLabel.text = [NSString stringWithFormat:@"Duration: %f", duration];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    elapsedLabel.text = [NSString stringWithFormat:@"Elapsed: %f", elapsed];
    
    BOOL running = [taskInfo.isRunning boolValue];
    if (running == YES) 
    {
        [timerButton setTitle:@"Stop Working" forState:UIControlStateNormal];
        [self continueTimer];
        
    }
    else
    {
        [timerButton setTitle:@"Start Working" forState:UIControlStateNormal];
        //timeLeft = duration - elapsed;
        
        
    }
     */
}

- (void) viewWillUnload
{
    [super viewWillUnload];
    NSLog(@"viewWillUnload");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"viewDidUnload");
}

- (void) viewWillDisappear:(BOOL)animated
{
    [countdownTimer invalidate];
    countdownTimer = nil;
}

- (void) viewDidDisappear:(BOOL)animated
{
    //NSLog(@"viewDidDisappear");
    //[self stopTimer];
    //[countdownTimer invalidate];
    //countdownTimer = nil;
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

- (void) startTimer
{
    NSLog(@"startTimer");
    double duration = [taskInfo.duration doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    timeLeft = duration - elapsed;
    NSDate *start = [NSDate date];
    //NSTimeInterval = timeLeft;
    //NSLog(@"timeLeft is %f", timeLeft);
    NSDate *end = [start dateByAddingTimeInterval:timeLeft];
    NSNumber *running = [NSNumber numberWithBool:YES];
    [taskInfo setValue:start forKey:@"startTime"];
    [taskInfo setValue:end forKey:@"projectedEndTime"];
    [taskInfo setValue:running forKey:@"isRunning"];
    
    NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
    
    //[self setLocalNotification];
    [self cancelReminder:taskInfo];
    [self scheduleAlarm];
    
    //double duration = [taskInfo.duration doubleValue];
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    //timeLeft = duration - elapsed;
    
    // start timerCountdown label
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
    
}

- (void) stopTimer
{
    NSLog(@"stopTimer");
    //NSDate *start = [NSDate date];
    //NSTimeInterval = timeLeft;
    //NSDate *end = [start dateByAddingTimeInterval:timeLeft];
    NSNumber *running = [NSNumber numberWithBool:NO];
    
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double duration = [taskInfo.duration doubleValue];
    
    elapsed = (duration - timeLeft);
    NSNumber *elapsedNumber = [NSNumber numberWithDouble:elapsed];
    [taskInfo setValue:elapsedNumber forKey:@"elapsedTime"];
    
    //[taskInfo setValue:start forKey:@"startTime"];
    //[taskInfo setValue:end forKey:@"projectedEndTime"];
    [taskInfo setValue:running forKey:@"isRunning"];
    
    NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
    
    
    /*
    // need to disable notification for timer
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = nil;
    for (notification in notificationArray) {
        NSString *title = [notification.userInfo objectForKey:@"title"];
        NSString *type = [notification.userInfo objectForKey:@"type"];
        //NSDate *endTime = [notification.userInfo objectForKey:@"endTime"];
        //if ((title == taskInfo.title) && (endTime == taskInfo.projectedEndTime))
        //check for notification type "alarm"
        if (([title isEqualToString:taskInfo.title]) && ([type isEqualToString:@"alarm"]))
        {
            //notification.applicationIconBadgeNumber--;
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
     */
    
    [self scheduleReminder:taskInfo];
    [self cancelAlarm];
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    
}

- (void) continueTimer
{
    NSLog(@"continueTimer");
    
    NSDate *endTime = taskInfo.projectedEndTime;
    //NSDate *startTime = taskInfo.startTime;
    //NSTimeInterval = timeLeft;
    //NSDate *now = [NSDate date];
    //double duration = 
    //double timeDiff = [endTime timeIntervalSinceDate:startTime];
    double timeSinceNow = [endTime timeIntervalSinceNow];
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    //double duration = [taskInfo.duration doubleValue];
    //NSLog(@"timeDiff is %f", timeDiff);
    //NSLog(@"timeLeft is %f", timeLeft);
    //NSLog(@"timeSinceNow is %f", timeSinceNow);
    //NSLog(@"elapsed is %f", elapsed);
    //NSLog(@"duration is %f", duration);
    
    timeSinceNow = nearbyint(timeSinceNow);
    //NSLog(@"timeSinceNow is now %f", timeSinceNow);
    
    //NSLog(@"timeLeft is %f", timeLeft);
    
    timeLeft = timeSinceNow;
    
    // start timerCountdown label
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
}

- (void) endTimer
{
    NSLog(@"endTimer");
    /*
    NSDate *finishDate = [NSDate date];
    //NSTimeInterval = timeLeft;
    //NSDate *end = [start dateByAddingTimeInterval:timeLeft];
    NSNumber *running = [NSNumber numberWithBool:NO];
    
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double duration = [taskInfo.duration doubleValue];
    
    elapsed = (duration - timeLeft);
    NSNumber *elapsedNumber = [NSNumber numberWithDouble:elapsed];
    [taskInfo setValue:elapsedNumber forKey:@"elapsedTime"];
    
    [taskInfo setValue:finishDate forKey:@"completionDate"];
    NSNumber *completed = [NSNumber numberWithBool:YES];
    [taskInfo setValue:completed forKey:@"isCompleted"];
    
    NSNumber *todayBOOL = [NSNumber numberWithBool:NO];
    [taskInfo setValue:todayBOOL forKey:@"isToday"];
    
    //[taskInfo setValue:start forKey:@"startTime"];
    //[taskInfo setValue:end forKey:@"projectedEndTime"];
    [taskInfo setValue:running forKey:@"isRunning"];
    
    NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
    */
     
    [timerButton setTitle:@"Done" forState:UIControlStateNormal];
    [timerButton setEnabled:NO];
    
    [countdownTimer invalidate];
    countdownTimer = nil;
}

- (void)finishTimer
{
    [finishEarlyButton setEnabled:NO];
    [self endTimer];
    
    [self cancelAlarm];
    
    NSDate *finishDate = [NSDate date];
    //NSTimeInterval = timeLeft;
    //NSDate *end = [start dateByAddingTimeInterval:timeLeft];
    NSNumber *running = [NSNumber numberWithBool:NO];
    
    double elapsed = [taskInfo.elapsedTime doubleValue];
    //double duration = [taskInfo.duration doubleValue];
    
    //elapsed = (duration - timeLeft);
    NSNumber *elapsedNumber = [NSNumber numberWithDouble:elapsed];
    [taskInfo setValue:elapsedNumber forKey:@"elapsedTime"];
    
    
    [taskInfo setValue:finishDate forKey:@"completionDate"];
    NSNumber *completed = [NSNumber numberWithBool:YES];
    [taskInfo setValue:completed forKey:@"isCompleted"];
    
    NSNumber *todayBOOL = [NSNumber numberWithBool:NO];
    [taskInfo setValue:todayBOOL forKey:@"isToday"];
    
    //[taskInfo setValue:start forKey:@"startTime"];
    //[taskInfo setValue:end forKey:@"projectedEndTime"];
    [taskInfo setValue:running forKey:@"isRunning"];
    
    //NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
    
}

- (void) updateCountdownLabel
{
    //NSLog(@"updateCountdownLabel");
    countdownLabel.text = [NSString stringWithFormat:@"%f", timeLeft];
    if (timeLeft >0) {
        timeLeft--;
    }
    else
    {
        NSLog(@"finish task");
        [self endTimer];
    }
}

#pragma mark -
#pragma mark Local Notification

- (void) setLocalNotification
{
    NSLog(@"setLocalNotification");
    NSLog(@"taskInfo is %@", taskInfo);
    
    // for now, only one notification at a time
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    //localNotification.alertLaunchImage
    localNotification.fireDate = taskInfo.projectedEndTime;
    //localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is done", taskInfo.title];
    localNotification.alertAction = @"Finish";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [taskInfo objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    //NSString *taskURLString = [NSString stri
    
    
    NSString *URLstring = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:taskInfo.title, @"title", taskInfo.projectedEndTime, @"endTime", URLstring, @"taskURLString", @"alarm", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
    
    
    
}

#pragma mark -
#pragma mark Reminders and Alarms

- (void) scheduleAlarm
{
    NSLog(@"scheduleAlarm");
    NSLog(@"taskInfo is %@", taskInfo);
    
    // for now, only one notification at a time
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    //localNotification.alertLaunchImage
    localNotification.fireDate = taskInfo.projectedEndTime;
    //localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is done", taskInfo.title];
    localNotification.alertAction = @"Finish";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [taskInfo objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    //NSString *taskURLString = [NSString stri
    
    
    NSString *URLstring = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:taskInfo.title, @"title", taskInfo.projectedEndTime, @"endTime", URLstring, @"taskURLString", @"alarm", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
}

- (void) cancelAlarm
{
    NSLog(@"cancelAlarm for %@", taskInfo);
    // need to disable notification for timer
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = nil;
    for (notification in notificationArray) {
        NSString *title = [notification.userInfo objectForKey:@"title"];
        NSString *type = [notification.userInfo objectForKey:@"type"];
        //NSDate *endTime = [notification.userInfo objectForKey:@"endTime"];
        //if ((title == taskInfo.title) && (endTime == taskInfo.projectedEndTime))
        //check for notification type "alarm"
        if (([title isEqualToString:taskInfo.title]) && ([type isEqualToString:@"alarm"]))
        {
            //notification.applicationIconBadgeNumber--;
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

- (void) scheduleReminder:(TaskInfo *)task
{
    NSLog(@"scheduleReminder with %@", task);
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    
    /*
     need to figure out precisely when to fire timer, some factors:
     1. how much time left in day vs. how much time left in task
     2. time zone
     3. how many times have you been reminded? should i keep track of that? probably, but won't for now
     4. how long duration is in general. Remind more frequently for shorter tasks but can't take 3 hours to remind for a 3 hour task
     
     */
    double duration = [task.duration doubleValue];
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    //double reminderTime = duration - elapsed;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:duration];
    localNotification.fireDate = date;
    localNotification.alertBody = [NSString stringWithFormat:@"%@ still needs work today", task.title];
    localNotification.alertAction = @"Start Working";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [task objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    
    NSString *URLString = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:task.title, @"title", URLString, @"taskURLString", @"reminder", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
    
    
    
}

- (void) cancelReminder:(TaskInfo *)task
{
    NSLog(@"cancelReminder for %@", task);
    
    // need to disable notification for timer
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = nil;
    for (notification in notificationArray) {
        NSString *title = [notification.userInfo objectForKey:@"title"];
        NSString *type = [notification.userInfo objectForKey:@"type"];
        //NSDate *endTime = [notification.userInfo objectForKey:@"endTime"];
        //if ((title == taskInfo.title) && (endTime == taskInfo.projectedEndTime))
        //check for notification type "alarm"
        if (([title isEqualToString:task.title]) && ([type isEqualToString:@"reminder"]))
        {
            //notification.applicationIconBadgeNumber--;
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            
            // **** do i need to release this notification???
        }
    }
    
    
}


#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [titleLabel release];
    [durationLabel release];
    [elapsedLabel release];
    [countdownTimer release];
    [countdownLabel release];
    
    [super dealloc];
}

@end
