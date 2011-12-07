//
//  MetaDataWrapper.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "MetaDataWrapper.h"


@implementation MetaDataWrapper

#pragma mark -
#pragma mark Lifecycle Methods

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void) dealloc
{
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

- (void) addNewTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
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
    
    
    [self writeToPlist:metadata];
}

- (void) startTask:(TaskInfo *)taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
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
    
    
    [self writeToPlist:metadata];
}

- (void) deleteTask:(TaskInfo *) taskInfo
{
    
    // ******** needs work *********
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
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
    
    [self writeToPlist:metadata];
}

- (void) stopTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
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
    
    [self writeToPlist:metadata];
}

- (void) endTask:(TaskInfo *) taskInfo
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
    
    [self writeToPlist:metadata];
    
    
}

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

- (void) changeToday:(TaskInfo *)taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    BOOL isToday = [taskInfo.isToday boolValue];
    
    if (isToday == YES) {
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
        // increase timeleft
        double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
        todayTimeLeft = todayTimeLeft + [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
        // increase elapsed
        double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
        todayTimeElapsed = todayTimeElapsed + [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
    }
    else
    {
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
        double todayTimeLeft = [[todayTasks objectForKey:@"TimeLeft"] doubleValue];
        todayTimeLeft = todayTimeLeft - [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeLeft] forKey:@"TimeLeft"];
        // decrease elapsed
        double todayTimeElapsed = [[todayTasks objectForKey:@"TimeElapsed"] doubleValue];
        todayTimeElapsed = todayTimeElapsed - [taskInfo.elapsedTime doubleValue];
        [todayTasks setObject:[NSNumber numberWithDouble:todayTimeElapsed] forKey:@"TimeElapsed"];
    }
    
    [self writeToPlist:metadata];
}

@end
