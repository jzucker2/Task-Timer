//
//  MetaDataWrapper.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskInfo.h"

@interface MetaDataWrapper : NSObject
{
    NSMutableDictionary *plistDict;
}
@property (nonatomic, retain) NSMutableDictionary *plistDict;

- (NSMutableDictionary *) fetchPList;

/*

- (NSMutableDictionary *) fetchNotificationDictionary;

- (NSMutableDictionary *) fetchAllTasksDictionary;

- (NSMutableDictionary *) fetchTodayTasksDictionary;

- (NSMutableDictionary *) fetchHistoryDictionary;
 */

- (void) writeToPlist:(NSMutableDictionary *) dictionary;

- (void) addNewTask:(TaskInfo *) taskInfo;

- (void) editTask:(TaskInfo *) taskInfo withOldDuration:(double)duration;

- (void) startTask:(TaskInfo *) taskInfo;

- (void) deleteTask:(TaskInfo *) taskInfo;

- (void) stopTask:(TaskInfo *) taskInfo;

- (void) closeTask:(TaskInfo *) taskInfo;

//- (void) finishTask:(TaskInfo *) taskInfo;

- (void) changeToday:(TaskInfo *) taskInfo;


#pragma mark - Change Notifications

- (NSInteger) totalNotifications;
- (NSInteger) activeAlarms;
- (NSInteger) activeReminders;
- (void) setTotalNotifications;
- (void) increaseAlarms:(BOOL)direction;
- (void) increaseReminders:(BOOL)direction;
- (void) addToAlarmArray:(BOOL)plusminus withTask:(TaskInfo *)taskInfo;
- (void) addToReminderArray:(BOOL)plusminus withTask:(TaskInfo *)taskInfo;

#pragma mark - Change All Tasks

- (NSInteger) allTasksTotal;
- (void) increaseAllTasksTotal:(BOOL) direction;
- (void) increaseAllTasksTimeLeft:(BOOL) direction withTime:(double)time;
- (void) increaseAllTasksTimeElapsed:(BOOL) direction withTime:(double)time;


#pragma mark - Change Today Tasks

- (NSInteger) todayTasksTotal;
- (void) increaseTodayTasksTotal:(BOOL) direction;
- (NSInteger) todayTasksActive;
- (void) increaseTodayTasksActive:(BOOL) direction;
- (void) increaseTodayTasksTimeLeft:(BOOL) direction withTime:(double)time;
- (void) increaseTodayTasksTimeElapsed:(BOOL) direction withTime:(double)time;

#pragma mark - Change History

- (NSInteger) historyTotalTasks;
- (void) increaseHistoryTotalTasks;
- (void) increaseHistoryTimeElapsedWithTime:(double)time;


@end
