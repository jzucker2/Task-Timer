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
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // update AllTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    
    BOOL isToday = [taskInfo.isToday boolValue];
    if (isToday == YES) {
        // update Today Tasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    }
    
    [self writeToPlist:metadata];
}

- (void) stopTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // update alltasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    
    [self writeToPlist:metadata];
}

- (void) endTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    
    // update history
    NSMutableDictionary *history = [metadata objectForKey:@"History"];
    
    [self writeToPlist:metadata];
    
    
}

- (void) finishTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // update notifications
    NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
    
    // update allTasks
    NSMutableDictionary *allTasks = [metadata objectForKey:@"AllTasks"];
    
    // update todayTasks
    NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    
    // update history
    NSMutableDictionary *history = [metadata objectForKey:@"History"];
    
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
        
        // update today tasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    }
    else
    {
        // update notifications
        NSMutableDictionary *notificationDict = [metadata objectForKey:@"Notifications"];
        
        // update today tasks
        NSMutableDictionary *todayTasks = [metadata objectForKey:@"TodayTasks"];
    }
    
    [self writeToPlist:metadata];
}

@end
