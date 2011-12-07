//
//  TaskInfo.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TaskInfo.h"


@implementation TaskInfo

@dynamic completionDate;
@dynamic creationDate;
@dynamic duration;
@dynamic elapsedTime;
@dynamic isCompleted;
@dynamic isRepeating;
@dynamic isRunning;
@dynamic isToday;
@dynamic projectedEndTime;
@dynamic specifics;
@dynamic startTime;
@dynamic title;
@dynamic timesReminded;

#pragma mark -
#pragma mark Handle Tasks

- (void) startTask
{
    
}

- (void) stopTask
{
    
}

- (void) endTask
{
    
}

#pragma mark -
#pragma mark Handle isToday

- (void) changeToday:(BOOL)newIsToday
{
    [self setValue:[NSNumber numberWithBool:newIsToday] forKey:@"isToday"];
    if (newIsToday == YES) {
        NSLog(@"set reminder");
        [self scheduleReminder];
    }
    else
    {
        NSLog(@"cancel reminder");
        [self cancelReminder];
    }
}


#pragma mark -
#pragma mark Notifications

- (void) scheduleReminder
{
    NSLog(@"scheduleReminder with %@", self);
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
    double duration = [self.duration doubleValue];
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    //double reminderTime = duration - elapsed;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:duration];
    localNotification.fireDate = date;
    localNotification.alertBody = [NSString stringWithFormat:@"%@ still needs work today", self.title];
    localNotification.alertAction = @"Start Working";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [self objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    
    NSString *URLString = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:self.title, @"title", URLString, @"taskURLString", @"reminder", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
}

- (void) cancelReminder
{
    NSLog(@"cancelReminder for %@", self);
    
    // need to disable notification for timer
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = nil;
    for (notification in notificationArray) {
        NSString *title = [notification.userInfo objectForKey:@"title"];
        NSString *type = [notification.userInfo objectForKey:@"type"];
        //NSDate *endTime = [notification.userInfo objectForKey:@"endTime"];
        //if ((title == taskInfo.title) && (endTime == taskInfo.projectedEndTime))
        //check for notification type "alarm"
        if (([title isEqualToString:self.title]) && ([type isEqualToString:@"reminder"]))
        {
            //notification.applicationIconBadgeNumber--;
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            
            // **** do i need to release this notification???
        }
    }
}

- (void) scheduleAlarm
{
    NSLog(@"scheduleAlarm");
    NSLog(@"taskInfo is %@", self);
    
    // for now, only one notification at a time
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    //localNotification.alertLaunchImage
    localNotification.fireDate = self.projectedEndTime;
    //localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is done", self.title];
    localNotification.alertAction = @"Finish";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [self objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    //NSString *taskURLString = [NSString stri
    
    
    NSString *URLstring = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:self.title, @"title", self.projectedEndTime, @"endTime", URLstring, @"taskURLString", @"alarm", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
}

- (void) cancelAlarm
{
    NSLog(@"cancelAlarm for %@", self);
    // need to disable notification for timer
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = nil;
    for (notification in notificationArray) {
        NSString *title = [notification.userInfo objectForKey:@"title"];
        NSString *type = [notification.userInfo objectForKey:@"type"];
        //NSDate *endTime = [notification.userInfo objectForKey:@"endTime"];
        //if ((title == taskInfo.title) && (endTime == taskInfo.projectedEndTime))
        //check for notification type "alarm"
        if (([title isEqualToString:self.title]) && ([type isEqualToString:@"alarm"]))
        {
            //notification.applicationIconBadgeNumber--;
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

@end
