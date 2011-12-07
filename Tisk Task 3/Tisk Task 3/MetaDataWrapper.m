//
//  MetaDataWrapper.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "MetaDataWrapper.h"

@implementation MetaDataWrapper

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

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

- (void) addNewTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // increment number of all tasks
    NSInteger numberAllTasks = [[metadata objectForKey:@"NumberAllTasks"] integerValue];
    numberAllTasks++;
    [metadata setObject:[NSNumber numberWithInteger:numberAllTasks] forKey:@"NumberAllTasks"];
    
    // increase time left for all tasks by duration
    double timeLeftAll = [[metadata objectForKey:@"TimeLeftAllTasks"] doubleValue];
    timeLeftAll += [taskInfo.duration doubleValue];
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
}

- (void) startTask:(TaskInfo *)taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // increment number of active tasks
    NSInteger numberActiveTasks = [[metadata objectForKey:@"NumberActiveTasks"] integerValue];
    numberActiveTasks++;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveTasks] forKey:@"NumberActiveTasks"];
    
    // increase number active alarms
    NSInteger numberActiveAlarms = [[metadata objectForKey:@"NumberActiveAlarms"] integerValue];
    numberActiveAlarms++;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveAlarms] forKey:@"NumberActiveAlarms"];
    
    // decrease number active reminders
    NSInteger numberActiveReminders = [[metadata objectForKey:@"NumberActiveReminders"] integerValue];
    numberActiveReminders--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveReminders] forKey:@"NumberActiveReminders"];
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
}

- (void) deleteTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
}

- (void) stopTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // decrement number of active tasks
    NSInteger numberActiveTasks = [[metadata objectForKey:@"NumberActiveTasks"] integerValue];
    numberActiveTasks--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveTasks] forKey:@"NumberActiveTasks"];
    
    // decrease number active alarms
    NSInteger numberActiveAlarms = [[metadata objectForKey:@"NumberActiveAlarms"] integerValue];
    numberActiveAlarms--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveAlarms] forKey:@"NumberActiveAlarms"];
    
    // increase number active reminders
    NSInteger numberActiveReminders = [[metadata objectForKey:@"NumberActiveReminders"] integerValue];
    numberActiveReminders++;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveReminders] forKey:@"NumberActiveReminders"];
    
    // update time left today
    double timeLeftToday = [[metadata objectForKey:@"TimeLeftToday"] doubleValue];
    timeLeftToday = timeLeftToday - [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeLeftToday] forKey:@"TimeLeftToday"];
    
    // update time spent today
    double timeSpentToday = [[metadata objectForKey:@"TimeSpentToday"] doubleValue];
    timeSpentToday = timeSpentToday + [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeSpentToday] forKey:@"TimeSpentToday"];
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
}

- (void) endTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // decrement number of active tasks
    NSInteger numberActiveTasks = [[metadata objectForKey:@"NumberActiveTasks"] integerValue];
    numberActiveTasks--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveTasks] forKey:@"NumberActiveTasks"];
    
    // decrease number active alarms
    NSInteger numberActiveAlarms = [[metadata objectForKey:@"NumberActiveAlarms"] integerValue];
    numberActiveAlarms--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveAlarms] forKey:@"NumberActiveAlarms"];
    
    // update time left today
    double timeLeftToday = [[metadata objectForKey:@"TimeLeftToday"] doubleValue];
    timeLeftToday = timeLeftToday - [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeLeftToday] forKey:@"TimeLeftToday"];
    
    // update time spent today
    double timeSpentToday = [[metadata objectForKey:@"TimeSpentToday"] doubleValue];
    timeSpentToday = timeSpentToday + [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeSpentToday] forKey:@"TimeSpentToday"];
    
    // increase tasks finished today
    NSInteger tasksFinishedToday = [[metadata objectForKey:@"TasksFinishedToday"] integerValue];
    tasksFinishedToday--;
    [metadata setObject:[NSNumber numberWithInteger:tasksFinishedToday] forKey:@"TasksFinishedToday"];
    
    // increase tasks finished overall
    NSInteger tasksFinishedOverall = [[metadata objectForKey:@"OverallTasksFinished"] integerValue];
    tasksFinishedOverall--;
    [metadata setObject:[NSNumber numberWithInteger:tasksFinishedOverall] forKey:@"OverallTasksFinished"];
    
    // increase overall time spent
    double overallTimeSpent = [[metadata objectForKey:@"OverallTimeSpent"] doubleValue];
    overallTimeSpent = overallTimeSpent + [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:overallTimeSpent] forKey:@"OverallTimeSpent"];
    
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
    
    
}

- (void) finishTask:(TaskInfo *) taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    // decrement number of active tasks
    NSInteger numberActiveTasks = [[metadata objectForKey:@"NumberActiveTasks"] integerValue];
    numberActiveTasks--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveTasks] forKey:@"NumberActiveTasks"];
    
    // decrease number active alarms
    NSInteger numberActiveAlarms = [[metadata objectForKey:@"NumberActiveAlarms"] integerValue];
    numberActiveAlarms--;
    [metadata setObject:[NSNumber numberWithInteger:numberActiveAlarms] forKey:@"NumberActiveAlarms"];
    
    // update time left today
    double timeLeftToday = [[metadata objectForKey:@"TimeLeftToday"] doubleValue];
    timeLeftToday = timeLeftToday - [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeLeftToday] forKey:@"TimeLeftToday"];
    
    // update time spent today
    double timeSpentToday = [[metadata objectForKey:@"TimeSpentToday"] doubleValue];
    timeSpentToday = timeSpentToday + [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeSpentToday] forKey:@"TimeSpentToday"];
    
    // increase tasks finished today
    NSInteger tasksFinishedToday = [[metadata objectForKey:@"TasksFinishedToday"] integerValue];
    tasksFinishedToday--;
    [metadata setObject:[NSNumber numberWithInteger:tasksFinishedToday] forKey:@"TasksFinishedToday"];
    
    // increase tasks finished overall
    NSInteger tasksFinishedOverall = [[metadata objectForKey:@"OverallTasksFinished"] integerValue];
    tasksFinishedOverall--;
    [metadata setObject:[NSNumber numberWithInteger:tasksFinishedOverall] forKey:@"OverallTasksFinished"];
    
    // increase overall time spent
    double overallTimeSpent = [[metadata objectForKey:@"OverallTimeSpent"] doubleValue];
    overallTimeSpent = overallTimeSpent + [taskInfo.elapsedTime doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:overallTimeSpent] forKey:@"OverallTimeSpent"];
    
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
}

- (void) changeToday:(TaskInfo *)taskInfo
{
    // fetch metadata
    NSMutableDictionary *metadata = [self fetchPList];
    NSLog(@"metadata is %@", metadata);
    
    BOOL isToday = [taskInfo.isToday boolValue];
    
    // adjust number of tasks for today
    NSInteger tasksLeftToday = [[metadata objectForKey:@"TasksLeftToday"] integerValue];
    if (isToday == YES) {
        tasksLeftToday++;
    }
    else
    {
        tasksLeftToday--;
    }
    [metadata setObject:[NSNumber numberWithInteger:tasksLeftToday] forKey:@"TasksLeftToday"];
    
    // update number active reminders
    NSInteger numberActiveReminders = [[metadata objectForKey:@"NumberActiveReminders"] integerValue];
    if (isToday == YES) {
        numberActiveReminders++;
    }
    else
    {
        numberActiveReminders--;
    }
    [metadata setObject:[NSNumber numberWithInteger:numberActiveReminders] forKey:@"NumberActiveReminders"];
    
    
    
    // update time left for today
    double timeLeftToday = [[metadata objectForKey:@"TimeLeftToday"] doubleValue];
    double elapsed = [taskInfo.elapsedTime doubleValue];
    double duration = [taskInfo.duration doubleValue];
    double timeLeft = duration - elapsed;
    if (isToday == YES) {
        timeLeftToday = timeLeftToday + timeLeft;
    }
    else
    {
        timeLeftToday = timeLeftToday - timeLeft;
    }
    //timeLeftToday = timeLeftToday + [taskInfo.duration doubleValue];
    [metadata setObject:[NSNumber numberWithDouble:timeLeftToday] forKey:@"TimeLeftToday"];
    
    // find plist path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MetaData.plist"];
    
    // write to plist
    [metadata writeToFile:path atomically:YES];
}

- (void) dealloc
{
    [super dealloc];
}

@end
