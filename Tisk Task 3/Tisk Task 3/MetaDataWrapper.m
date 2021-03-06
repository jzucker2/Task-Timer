//
//  MetaDataWrapper.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "MetaDataWrapper.h"


@implementation MetaDataWrapper

@synthesize plistDict;

#pragma mark -
#pragma mark Lifecycle Methods

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
        plistDict = [[self fetchPList] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [plistDict release];
    [super dealloc];
}

#pragma mark -
#pragma mark Write to Plist

- (void) writeToPlist:(NSMutableDictionary *)dictionary
{
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [dictionary writeToFile:path atomically:YES];
}

#pragma mark -
#pragma mark Retrieval Methods

- (NSMutableDictionary *) fetchPList
{
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"MetaData.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"MetaData" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    // convert static property list into dictionary object
    NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp)
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        return nil;
    }
    
    //NSLog(@"plist is %@", temp);
    return temp;
}

/*
- (NSMutableDictionary *) fetchNotificationDictionary
{
    
}

- (NSMutableDictionary *) fetchAllTasksDictionary
{
    
}

- (NSMutableDictionary *) fetchTodayTasksDictionary
{
    
}

- (NSMutableDictionary *) fetchHistoryDictionary
{
    
}
 */

#pragma mark - Update Metadata Methods

#pragma mark Change Notifications

- (NSInteger) totalNotifications
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // update notifications
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    NSInteger totalNotifications = [[notificationDict objectForKey:@"Total"] integerValue];
    return totalNotifications;
}

- (NSInteger) activeAlarms
{
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    NSInteger activeAlarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    return activeAlarms;
}

- (NSInteger) activeReminders
{
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    NSInteger activeReminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
    return activeReminders;
}

- (void) addToAlarmArray:(BOOL)plusminus withTask:(TaskInfo *)taskInfo
{
    
}

- (void) addToReminderArray:(BOOL)plusminus withTask:(TaskInfo *)taskInfo
{
    
}

- (void) setTotalNotifications
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch notifications info
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    
    // count up alarms
    NSInteger totalAlarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    // count up reminders
    NSInteger totalReminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
    // add together to get new total notifications
    NSInteger total = totalAlarms + totalReminders;
    
    [notificationDict setObject:[NSNumber numberWithInteger:total] forKey:@"Total"];
    
    // still need to save new value to plist
}

- (void) increaseAlarms:(BOOL)direction
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch notifications info
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    
    // find old alarm total
    NSInteger totalAlarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    
    // change value based on direction
    if (direction == YES) {
        totalAlarms++;
    }
    else
    {
        totalAlarms--;
    }
    
    // set new alarm value
    [notificationDict setObject:[NSNumber numberWithInteger:totalAlarms] forKey:@"ActiveAlarms"];
    
}

- (void) increaseReminders:(BOOL)direction
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch notifications info
    NSMutableDictionary *notificationDict = [plistDict objectForKey:@"Notifications"];
    
    // find old alarm total
    NSInteger totalReminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
    
    // change value based on direction
    if (direction == YES) {
        totalReminders++;
    }
    else
    {
        totalReminders--;
    }
    
    // set new alarm value
    [notificationDict setObject:[NSNumber numberWithInteger:totalReminders] forKey:@"ActiveReminders"];
}

#pragma mark Change All Tasks

- (NSInteger) allTasksTotal
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch All Tasks Info
    NSMutableDictionary *allTasks = [plistDict objectForKey:@"AllTasks"];
    
    NSInteger total = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    
    return total;
}

- (void) increaseAllTasksTotal:(BOOL) direction
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch All Tasks Info
    NSMutableDictionary *allTasks = [plistDict objectForKey:@"AllTasks"];
    
    NSInteger total = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    
    // change based on direction
    if (direction == YES) {
        total++;
    }
    else
    {
        total--;
    }
    // set new total
    [allTasks setObject:[NSNumber numberWithInteger:total] forKey:@"TotalTasks"];
}


- (void) increaseAllTasksTimeLeft:(BOOL) direction withTime:(double)time
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    NSLog(@"increaseAllTasksTimeLeft with direction: %@ and time:%f", (direction ? @"YES" : @"NO"), time);
    NSLog(@"plist is %@", plistDict);
    
    // fetch All Tasks Info
    NSMutableDictionary *allTasks = [plistDict objectForKey:@"AllTasks"];
    
    // get old TimeLeft value
    double totalTimeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    NSLog(@"totalTimeLeft originally is %f", totalTimeLeft);
    
    // change timeLeft based on direction bool
    if (direction == YES) {
        totalTimeLeft += time;
    }
    else
    {
        totalTimeLeft -= time;
    }
    NSLog(@"totalTimeLeft is now %f", totalTimeLeft);
    
    // set new value
    [allTasks setObject:[NSNumber numberWithDouble:totalTimeLeft] forKey:@"TimeLeft"];
}

- (void) increaseAllTasksTimeElapsed:(BOOL) direction withTime:(double)time
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch All Tasks Info
    NSMutableDictionary *allTasks = [plistDict objectForKey:@"AllTasks"];
    
    // get old timeElapsed value
    double totalTimeElapsed = [[allTasks objectForKey:@"TimeElapsed"] doubleValue];
    
    // change timeElapsed based on direction bool
    if (direction == YES) {
        totalTimeElapsed += time;
    }
    else
    {
        totalTimeElapsed -= time;
    }
    
    // set new value
    [allTasks setObject:[NSNumber numberWithDouble:totalTimeElapsed] forKey:@"TimeElapsed"];
}



#pragma mark Change Today Tasks

- (NSInteger) todayTasksTotal
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get total tasks for today
    NSInteger total = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
    
    return total;
}

- (void) increaseTodayTasksTotal:(BOOL) direction
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get total tasks for today
    NSInteger total = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
    
    // change total based on direction bool
    if (direction == YES) {
        total++;
    }
    else
    {
        total--;
    }
    
    // set new total value
    [todayTasks setObject:[NSNumber numberWithInteger:total] forKey:@"TotalTasks"];
}

- (NSInteger) todayTasksActive
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get active tasks for today
    NSInteger active = [[todayTasks objectForKey:@"ActiveTasks"] integerValue];
    
    return active;
}

- (void) increaseTodayTasksActive:(BOOL) direction
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get active tasks for today
    NSInteger active = [[todayTasks objectForKey:@"ActiveTasks"] integerValue];
    
    // change active tasks total based on direction bool
    if (direction == YES) {
        active++;
    }
    else
    {
        active--;
    }
    
    // set new value
    [todayTasks setObject:[NSNumber numberWithInteger:active] forKey:@"ActiveTasks"];
}

- (void) increaseTodayTasksTimeLeft:(BOOL) direction withTime:(double)time
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get old today tasks timeLeft
    double totalTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
    
    // change total based on direction
    if (direction == YES) {
        totalTimeLeft += time;
    }
    else
    {
        totalTimeLeft -= time;
    }
    
    // set new value
    [todayTasks setObject:[NSNumber numberWithDouble:totalTimeLeft] forKey:@"TimeLeft"];
    
}

- (void) increaseTodayTasksTimeElapsed:(BOOL) direction withTime:(double)time
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch Today Tasks info
    NSMutableDictionary *todayTasks = [plistDict objectForKey:@"TodayTasks"];
    
    // get old today tasks timeLeft
    double totalTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
    
    // change total based on direction
    if (direction == YES) {
        totalTimeElapsed += time;
    }
    else
    {
        totalTimeElapsed -= time;
    }
    
    // set new value
    [todayTasks setObject:[NSNumber numberWithDouble:totalTimeElapsed] forKey:@"TimeElapsed"];
}


#pragma mark Change History

- (NSInteger) historyTotalTasks
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch history info
    NSMutableDictionary *history = [plistDict objectForKey:@"History"];
    // get total tasks finished
    NSInteger totalTasks = [[history objectForKey:@"TotalTasks"] integerValue];
    // return value
    return totalTasks;
}

- (void) increaseHistoryTotalTasks
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch history info
    NSMutableDictionary *history = [plistDict objectForKey:@"History"];
    // get total tasks finished
    NSInteger totalTasks = [[history objectForKey:@"TotalTasks"] integerValue];
    
    // increment total tasks finished
    totalTasks++;
    // store new value
    [history setObject:[NSNumber numberWithInteger:totalTasks] forKey:@"TotalTasks"];
    
}

- (void) increaseHistoryTimeElapsedWithTime:(double)time
{
    /*
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
     */
    
    // fetch history info
    NSMutableDictionary *history = [plistDict objectForKey:@"History"];
    // get history timeElapsed
    double totalTimeElapsed = [[history objectForKey:@"TimeElapsed"] doubleValue];
    
    // increase totalTimeElapsed
    totalTimeElapsed += time;
    
    // store new value
    [history setObject:[NSNumber numberWithDouble:totalTimeElapsed] forKey:@"TimeElapsed"];
}

#pragma mark - Task Status Change Methods

- (void) addNewTask:(TaskInfo *) taskInfo
{
    NSLog(@"addNewTask");
    //NSLog(@"taskInfo is %@", taskInfo);
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // update all Tasks metadata
    // first increase total tasks in all tasks
    [self increaseAllTasksTotal:YES];
    // next increase total time left in all tasks
    double timeLeft = [taskInfo.duration doubleValue];
    [self increaseAllTasksTimeLeft:YES withTime:timeLeft];
    
    
    /*
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    // first increase total tasks
    NSInteger totalTasks = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    totalTasks++;
    [allTasks setObject:[NSNumber numberWithInteger:totalTasks] forKey:@"TotalTasks"];
    // next increase timeleft
    double timeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    timeLeft = timeLeft + [taskInfo.duration doubleValue];
    [allTasks setObject:[NSNumber numberWithDouble:timeLeft] forKey:@"TimeLeft"];
     */
    
    
    [self writeToPlist:plistDict];
}

- (void) startTask:(TaskInfo *)taskInfo
{
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // first update notifications
    [self increaseAlarms:YES];
    [self increaseReminders:NO];
    [self setTotalNotifications];
    
    // update today tasks
    [self increaseTodayTasksActive:YES];
    
    
    /*
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    // don't change total, just decrement reminders and increment alarms
    // increment alarms
    NSInteger alarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    alarms++;
    [notificationDict setObject:[NSNumber numberWithInteger:alarms] forKey:@"ActiveAlarms"];
    // decrement reminders
    NSInteger reminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
    reminders--;
    [notificationDict setObject:[NSNumber numberWithInteger:reminders] forKey:@"ActiveReminders"];
     */
    
    
    [self writeToPlist:plistDict];
}

- (void) editTask:(TaskInfo *)taskInfo withOldDuration:(double)old_duration
{
    // needs more work!!!!!
    NSLog(@"metadata wrapper: editTask with %@", taskInfo);
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // important values
    //BOOL isRunning = [taskInfo.isRunning boolValue];
    BOOL isToday = [taskInfo.isToday boolValue];
    
    // need to calculate difference in timeLeft
    double newDuration = [taskInfo.duration doubleValue];
    double newTimeLeft;
    BOOL isIncreasingTimeLeft;
    // need to know whether task was made longer or shorter
    if (newDuration > old_duration) {
        // task is longer
        newTimeLeft = newDuration - old_duration;
        isIncreasingTimeLeft = YES;
        
    }
    else
    {
        // task is shorter
        newTimeLeft = old_duration - newDuration;
        isIncreasingTimeLeft = NO;
    }
    
    // update all tasks
    [self increaseAllTasksTimeLeft:isIncreasingTimeLeft withTime:newTimeLeft];
    
    // update today tasks if set for today
    if (isToday == YES) {
        // update time left
        [self increaseTodayTasksTimeLeft:isIncreasingTimeLeft withTime:newTimeLeft];
    }
    
     
    
    /*
    // update all tasks
    [self increaseAllTasksTimeLeft:NO withTime:timeLeft];
    
    // update today tasks if task is set for today
    if (isToday == YES) {
        [self increaseTodayTasksTotal:NO];
        // check if task is active/running
        if (isRunning == YES) {
            [self increaseTodayTasksActive:NO];
        }
        // decrease today task time left
        [self increaseTodayTasksTimeLeft:NO withTime:timeLeft];
        // decrease today task timeelapsed
        [self increaseTodayTasksTimeElapsed:NO withTime:elapsed];
    }
     */
    
    // store new meta data
    [self writeToPlist:plistDict];
    
}

- (void) deleteTask:(TaskInfo *) taskInfo
{
    
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // important values
    BOOL isRunning = [taskInfo.isRunning boolValue];
    BOOL isToday = [taskInfo.isToday boolValue];
    //double duration = [taskInfo.duration doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double timeLeft = [taskInfo timeLeft];
    
    // update notifications
    // check first to see if its running
    if (isRunning == YES) {
        [self increaseAlarms:NO];
        [taskInfo cancelAlarm];
    }
    if (isToday == YES) {
        [self increaseReminders:NO];
        [taskInfo cancelReminder];
    }
    [self setTotalNotifications];
    
    // update all tasks
    // decrement all tasks task total
    [self increaseAllTasksTotal:NO];
    // update all tasks time stamps
    [self increaseAllTasksTimeElapsed:NO withTime:elapsed];
    [self increaseAllTasksTimeLeft:NO withTime:timeLeft];
    
    // update today tasks if task is set for today
    if (isToday == YES) {
        [self increaseTodayTasksTotal:NO];
        // check if task is active/running
        if (isRunning == YES) {
            [self increaseTodayTasksActive:NO];
        }
        // decrease today task time left
        [self increaseTodayTasksTimeLeft:NO withTime:timeLeft];
        // decrease today task timeelapsed
        [self increaseTodayTasksTimeElapsed:NO withTime:elapsed];
    }
    
    /*
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    BOOL running = [taskInfo.isRunning boolValue];
    BOOL today = [taskInfo.isToday boolValue];
    if (today == YES) {
        if (running == YES) {
            // decrement alarms
            NSInteger alarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
            alarms--;
            [notificationDict setObject:[NSNumber numberWithInteger:alarms] forKey:@"ActiveAlarms"];
        }
        else
        {
            // decrement reminders
            NSInteger reminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
            reminders--;
            [notificationDict setObject:[NSNumber numberWithInteger:reminders] forKey:@"ActiveReminders"];
        }
    }
        
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    // first decrease total tasks
    NSInteger totalTasks = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    totalTasks--;
    [allTasks setObject:[NSNumber numberWithInteger:totalTasks] forKey:@"TotalTasks"];
    // next decrease timeleft
    double timeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    timeLeft = timeLeft - [taskInfo.duration doubleValue];
    [allTasks setObject:[NSNumber numberWithDouble:timeLeft] forKey:@"TimeLeft"];
    // next decrease timeelapsed
    double timeElapsed = [[allTasks objectForKey:@"TimeElapsed"] doubleValue];
    timeElapsed = timeElapsed - [taskInfo.elapsedTime doubleValue];
    [allTasks setObject:[NSNumber numberWithDouble:timeElapsed] forKey:@"TimeElapsed"];
    
    
    
    BOOL isToday = [taskInfo.isToday boolValue];
    if (isToday == YES) {
        // update Today Tasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
        // decrement total tasks
        NSInteger totalTasks = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
        totalTasks--;
        [todayTasks setObject:[NSNumber numberWithInteger:totalTasks] forKey:@"TotalTasks"];
        
        
    }
     */
    
    [self writeToPlist:plistDict];
}

- (void) stopTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // important info for updating
    //double duration = [taskInfo.duration doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    //double timeLeft = duration - elapsed;
    
    // update notifications
    [self increaseReminders:YES];
    [self increaseAlarms:NO];
    [self setTotalNotifications];
    
    // update all tasks
    [self increaseAllTasksTimeLeft:NO withTime:elapsed];
    [self increaseAllTasksTimeElapsed:YES withTime:elapsed];
    
    // update today tasks
    [self increaseTodayTasksActive:NO];
    [self increaseTodayTasksTimeLeft:NO withTime:elapsed];
    [self increaseTodayTasksTimeElapsed:YES withTime:elapsed];
    
    /*
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    // don't change total, just decrement reminders and increment alarms
    // decrement alarms
    NSInteger alarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    alarms--;
    [notificationDict setObject:[NSNumber numberWithInteger:alarms] forKey:@"ActiveAlarms"];
    // increment reminders
    NSInteger reminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
    reminders++;
    [notificationDict setObject:[NSNumber numberWithInteger:reminders] forKey:@"ActiveReminders"];
    
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    // next decrease timeleft
    double timeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    timeLeft = timeLeft - elapsed;
    [allTasks setObject:[NSNumber numberWithDouble:timeLeft] forKey:@"TimeLeft"];
    // next increase timeelapsed
    double timeElapsed = [[allTasks objectForKey:@"TimeElapsed"] doubleValue];
    timeElapsed = timeElapsed + elapsed;
    [allTasks setObject:[NSNumber numberWithDouble:timeElapsed] forKey:@"TimeElapsed"];
    
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    // decrement active tasks
    NSInteger activeTasks = [[todayTasks objectForKey:@"ActiveTasks"] integerValue];
    activeTasks--;
    [todayTasks setObject:[NSNumber numberWithInteger:activeTasks] forKey:@"ActiveTasks"];
    // decrease timeleft
    double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
    todayTimeLeft = todayTimeLeft - [taskInfo.elapsedTime doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
    // increase elapsed
    double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
    todayTimeElapsed = todayTimeElapsed + [taskInfo.elapsedTime doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
     */
    
    [self writeToPlist:plistDict];
}

- (void) closeTask:(TaskInfo *) taskInfo
{
    // should handle end tasked regardless of early or not
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is %@", metadata);
    
    // important info for updating
    //double duration = [taskInfo.duration doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double timeLeft = [taskInfo timeLeft];
    
    // update notifications
    [self increaseAlarms:NO];
    [self setTotalNotifications];
    
    // update all tasks
    [self increaseAllTasksTotal:NO];
    [self increaseAllTasksTimeLeft:NO withTime:timeLeft];
    [self increaseAllTasksTimeElapsed:NO withTime:elapsed];
    
    // update today tasks
    [self increaseTodayTasksTotal:NO];
    [self increaseTodayTasksActive:NO];
    [self increaseTodayTasksTimeLeft:NO withTime:timeLeft];
    [self increaseTodayTasksTimeElapsed:NO withTime:elapsed];
    
    // update history
    [self increaseHistoryTotalTasks];
    [self increaseHistoryTimeElapsedWithTime:elapsed];
    
    /*
    
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    // decrement total
    NSInteger totalNotes = [[notificationDict objectForKey:@"Total"] integerValue];
    totalNotes--;
    [notificationDict setObject:[NSNumber numberWithInteger:totalNotes] forKey:@"Total"];
    // decrement alarms
    NSInteger alarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    alarms--;
    [notificationDict setObject:[NSNumber numberWithInteger:alarms] forKey:@"ActiveAlarms"];
    
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    NSInteger totalAllTasks = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    totalAllTasks--;
    [allTasks setObject:[NSNumber numberWithInteger:totalAllTasks] forKey:@"TotalTasks"];
    // next decrease timeleft
    double timeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    timeLeft = timeLeft - elapsed;
    [allTasks setObject:[NSNumber numberWithDouble:timeLeft] forKey:@"TimeLeft"];
    // next increase timeelapsed
    double timeElapsed = [[allTasks objectForKey:@"TimeElapsed"] doubleValue];
    timeElapsed = timeElapsed + elapsed;
    [allTasks setObject:[NSNumber numberWithDouble:timeElapsed] forKey:@"TimeElapsed"];
    
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    // decrement total tasks
    NSInteger totalToday = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
    totalToday--;
    [todayTasks setObject:[NSNumber numberWithInteger:totalToday] forKey:@"TotalTasks"];
    // decrement active tasks
    NSInteger activeTasks = [[todayTasks objectForKey:@"ActiveTasks"] integerValue];
    activeTasks--;
    [todayTasks setObject:[NSNumber numberWithInteger:activeTasks] forKey:@"ActiveTasks"];
    // decrease timeleft
    double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
    todayTimeLeft = todayTimeLeft - [taskInfo.elapsedTime doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
    // increase elapsed
    double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
    todayTimeElapsed = todayTimeElapsed + [taskInfo.elapsedTime doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
    
    // update history
    NSMutableDictionary *history = [metadata objectForKey:@"History"];
    NSInteger historyTasks = [[history objectForKey:@"TotalTasks"] integerValue];
    historyTasks++;
    [history setObject:[NSNumber numberWithInteger:historyTasks] forKey:@"TotalTasks"];
    double historyElapsed = [[history objectForKey:@"TimeElapsed"] doubleValue];
    historyElapsed = historyElapsed + [taskInfo.elapsedTime doubleValue];
    [history setObject:[NSNumber numberWithDouble:historyElapsed] forKey:@"TimeElapsed"];
     */
    
    [self writeToPlist:plistDict];
    
    
}

/*
- (void) finishTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    // decrement total
    NSInteger totalNotes = [[notificationDict objectForKey:@"Total"] integerValue];
    totalNotes--;
    [notificationDict setObject:[NSNumber numberWithInteger:totalNotes] forKey:@"Total"];
    // decrement alarms
    NSInteger alarms = [[notificationDict objectForKey:@"ActiveAlarms"] integerValue];
    alarms--;
    [notificationDict setObject:[NSNumber numberWithInteger:alarms] forKey:@"ActiveAlarms"];
    
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    NSInteger totalAllTasks = [[allTasks objectForKey:@"TotalTasks"] integerValue];
    totalAllTasks--;
    [allTasks setObject:[NSNumber numberWithInteger:totalAllTasks] forKey:@"TotalTasks"];
    // next decrease timeleft
    double timeLeft = [[allTasks objectForKey:@"TimeLeft"] doubleValue];
    double duration = [taskInfo.duration doubleValue];
    timeLeft = timeLeft - duration;
    [allTasks setObject:[NSNumber numberWithDouble:timeLeft] forKey:@"TimeLeft"];
    // next increase timeelapsed
    double timeElapsed = [[allTasks objectForKey:@"TimeElapsed"] doubleValue];
    timeElapsed = timeElapsed + [taskInfo.elapsedTime doubleValue];
    [allTasks setObject:[NSNumber numberWithDouble:timeElapsed] forKey:@"TimeElapsed"];
    
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    // decrement total tasks
    NSInteger totalToday = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
    totalToday--;
    [todayTasks setObject:[NSNumber numberWithInteger:totalToday] forKey:@"TotalTasks"];
    // decrement active tasks
    NSInteger activeTasks = [[todayTasks objectForKey:@"ActiveTasks"] integerValue];
    activeTasks--;
    [todayTasks setObject:[NSNumber numberWithInteger:activeTasks] forKey:@"ActiveTasks"];
    // decrease timeleft
    double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
    todayTimeLeft = todayTimeLeft - [taskInfo.duration doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
    // increase elapsed
    double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
    todayTimeElapsed = todayTimeElapsed + [taskInfo.elapsedTime doubleValue];
    [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
    
    // update history
    NSMutableDictionary *history = [metadata objectForKey:@"History"];
    NSInteger historyTasks = [[history objectForKey:@"TotalTasks"] integerValue];
    historyTasks++;
    [history setObject:[NSNumber numberWithInteger:historyTasks] forKey:@"TotalTasks"];
    double historyElapsed = [[history objectForKey:@"TimeElapsed"] doubleValue];
    historyElapsed = historyElapsed + [taskInfo.elapsedTime doubleValue];
    [history setObject:[NSNumber numberWithDouble:historyElapsed] forKey:@"TimeElapsed"];
    
    [self writeToPlist:metadata];
}
 */

- (void) changeToday:(TaskInfo *)taskInfo
{
    //NSLog(@"changeToday in metadataWrapper");
    // fetch metadata
    //NSMutableDictionary *metadata = [self fetchPList];
    //NSLog(@"metadata is initially %@", metadata);
    
    // important values for updating metadata
    BOOL isToday = [taskInfo.isToday boolValue];
    //double duration = [taskInfo.duration doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double timeLeft = [taskInfo timeLeft];
    
    if (isToday == YES) {
        // update notifications
        [self increaseReminders:YES];
        [self setTotalNotifications];
        
        // update today tasks
        [self increaseTodayTasksTotal:YES];
        [self increaseTodayTasksTimeLeft:YES withTime:timeLeft];
        [self increaseTodayTasksTimeElapsed:YES withTime:elapsed];
        
        
        /*
        // update notifications
        NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
        // increment total
        NSInteger totalNotes = [[notificationDict objectForKey:@"Total"] integerValue];
        totalNotes++;
        [notificationDict setObject:[NSNumber numberWithInteger:totalNotes] forKey:@"Total"];
        // increment reminders
        NSInteger reminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
        reminders++;
        [notificationDict setObject:[NSNumber numberWithInteger:reminders] forKey:@"ActiveReminders"];
        
        // update todayTasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
        // increment total tasks
        NSInteger totalToday = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
        totalToday++;
        [todayTasks setObject:[NSNumber numberWithInteger:totalToday] forKey:@"TotalTasks"];
        // increase timeleft for today
        double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
        double taskTimeLeft = [taskInfo.duration doubleValue] - [taskInfo.elapsedTime doubleValue];
        todayTimeLeft = todayTimeLeft + taskTimeLeft;
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
        // increase elapsed
        double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
        todayTimeElapsed = todayTimeElapsed + [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
         */
    }
    else
    {
        // update notifications
        [self increaseReminders:NO];
        [self setTotalNotifications];
        
        // update today tasks
        [self increaseTodayTasksTotal:NO];
        [self increaseTodayTasksTimeLeft:NO withTime:timeLeft];
        [self increaseTodayTasksTimeElapsed:NO withTime:elapsed];
        
        /*
        // update notifications
        NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
        // decrement total
        NSInteger totalNotes = [[notificationDict objectForKey:@"Total"] integerValue];
        totalNotes--;
        [notificationDict setObject:[NSNumber numberWithInteger:totalNotes] forKey:@"Total"];
        // decrement reminders
        NSInteger reminders = [[notificationDict objectForKey:@"ActiveReminders"] integerValue];
        reminders--;
        [notificationDict setObject:[NSNumber numberWithInteger:reminders] forKey:@"ActiveReminders"];
        
        // update todayTasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
        // decrement total tasks
        NSInteger totalToday = [[todayTasks objectForKey:@"TotalTasks"] integerValue];
        totalToday--;
        [todayTasks setObject:[NSNumber numberWithInteger:totalToday] forKey:@"TotalTasks"];
        // decrease timeleft
        double taskTimeLeft = [taskInfo.duration doubleValue] - [taskInfo.elapsedTime doubleValue];
        double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
        todayTimeLeft = todayTimeLeft - taskTimeLeft;
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
        // decrease elapsed
        double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
        todayTimeElapsed = todayTimeElapsed - [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
         */
    }
    
    //NSLog(@"metadata is now %@", metadata);
    
    [self writeToPlist:plistDict];
}

@end
