//
//  TaskInfo.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/10/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TaskInfo : NSManagedObject

@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * elapsedTime;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSNumber * isRepeating;
@property (nonatomic, retain) NSNumber * isRunning;
@property (nonatomic, retain) NSNumber * isToday;
@property (nonatomic, retain) NSDate * projectedEndTime;
@property (nonatomic, retain) NSString * specifics;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * timesReminded;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isFinishedEarly;
@property (nonatomic, retain) NSNumber * priority;

- (double) timeLeft;

- (void) startTask;

- (void) stopTask;

- (void) endTask;

- (void) finishTask;

- (void) changeToday:(BOOL)today;

- (void) scheduleReminder;

- (void) cancelReminder;

- (void) scheduleAlarm;

- (void) cancelAlarm;

- (double) calculateTimeUntilReminder;

@end
