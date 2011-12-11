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

- (NSMutableDictionary *) fetchPList;

/*

- (NSMutableDictionary *) fetchNotificationDictionary;

- (NSMutableDictionary *) fetchAllTasksDictionary;

- (NSMutableDictionary *) fetchTodayTasksDictionary;

- (NSMutableDictionary *) fetchHistoryDictionary;
 */

- (void) writeToPlist:(NSMutableDictionary *) dictionary;

- (void) addNewTask:(TaskInfo *) taskInfo;

- (void) startTask:(TaskInfo *) taskInfo;

- (void) deleteTask:(TaskInfo *) taskInfo;

- (void) stopTask:(TaskInfo *) taskInfo;

- (void) endTask:(TaskInfo *) taskInfo;

- (void) finishTask:(TaskInfo *) taskInfo;

- (void) changeToday:(TaskInfo *) taskInfo;


#pragma mark - Change Notifications

- (NSInteger) totalNotifications;
- (void) setTotalNotifications;
- (void) increaseAlarms:(BOOL)direction;
- (void) increaseReminders:(BOOL)direction;

#pragma mark - Change All Tasks

- (NSInteger) allTasksTotal;
- (void) increaseAllTasksTotal:(BOOL) direction;
- (void) increaseAllTasksTimeLeft:(BOOL) direction;
- (void) increaseAllTasksTimeElapsed:(BOOL) direction;

#pragma mark - Change Today Tasks

- (NSInteger) todayTasksTotal;
- (void) increaseTodayTasksTotal:(BOOL) direction;
- (void) increaseTodayTasksActive:(BOOL) direction;
- (void) increaseTodayTasksTimeLeft:(BOOL) direction;
- (void) increaseTodayTasksTimeElapsed:(BOOL) direction;

#pragma mark - Change History

- (NSInteger) historyTotalTasks;
- (void) increaseHistoryTotalTasks;
- (void) increaseHistoryTimeElapsed;

@end
